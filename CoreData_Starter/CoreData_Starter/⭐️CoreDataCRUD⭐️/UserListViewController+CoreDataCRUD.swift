//
//  UserListViewController+CoreDataCRUD.swift
//  CoreData_Starter
//

import CoreData
import UIKit

//MARK: - ⭐️ CoreData CURD 구현하기 ⭐️
extension UserListViewController: CoreDataManagable {
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).container.viewContext
    }
    
    func saveCoreData(_ data: User) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData에 User data를 저장하세요.
        // ---------------------------------------------------------------------------------------------------------//
        let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
        
        if let entity = entity {
            let user = NSManagedObject(entity: entity, insertInto: context)
            user.setValue(data.id, forKey: "id")
            user.setValue(data.name, forKey: "name")
            user.setValue(NSSet(), forKey: "jokes")
            
            do {
                try context.save()
                print(">>> 저장 완료!! : \(#function)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCoreData() -> [User] {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 모든 User data를 가져오세요.
        // ---------------------------------------------------------------------------------------------------------//
//        return User.sampleUsers // 샘플 데이터입니다. CoreData에서 받아올 수 있도록 변경해보세요.
        let request = UserEntity.fetchRequest()
        
        guard let userEntities = try? context.fetch(request)
        else {
            return []
        }
        
        let users = userEntities.map { userEntity in
            let jokeEntities = userEntity.jokes as! Set<JokeEntity>
            let jokes = jokeEntities.map { jokeEntity in
                let joke = Joke(
                    id: jokeEntity.id!,
                    content: jokeEntity.content!,
                    category: Category(rawValue: Int(jokeEntity.category))!
                )
                
                return joke
            }
            let user = User(id: userEntity.id!, name: userEntity.name!, jokes: jokes)
            
            return user
        }
        
        print(">>> 페칭 완료!! : \(#function)")
        return users
    }
    
    func updateCoreData(_ data: User) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 특정 User data를 업데이트하세요.
        // ---------------------------------------------------------------------------------------------------------//
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", data.id.uuidString)
        
        guard let userEntity = try? context.fetch(request).first else { return }
        userEntity.setValue(data.name, forKey: "name")
        
        do {
            try context.save()
            print(">>> 업데이트 완료!! : \(#function)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCoreData(_ data: User) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 특정 User data를 삭제하세요.
        // ---------------------------------------------------------------------------------------------------------//
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", data.id.uuidString)
        
        guard let userEntity = try? context.fetch(request).first else { return }
        context.delete(userEntity)
        
        do {
            try context.save()
            print(">>> 삭제 완료!! : \(#function)")
        } catch {
            print(error)
        }
    }
}
