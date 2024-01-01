//
//  JokeTabBarController+CoreDataCRUD.swift
//  CoreData_Starter
//

import CoreData
import UIKit

//MARK: - ⭐️ CoreData CURD 구현하기 ⭐️
extension JokeTabBarController: CoreDataManagable {
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).container.viewContext
    }
    
    func saveCoreData(currentUser: User, _ data: Joke) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData에 Joke data를 저장하세요.
        // 1. 우선 currentUser 파라미터를 사용하지 말고, Joke data를 저장해보세요.
        // 2. 나중에 User에 관한 CoreData CRUD가 완성이 되면, 그때 currentUser 파라미터를 사용하여 Relationship을 설정하도록 해봅니다.
        // ---------------------------------------------------------------------------------------------------------//
        let userRequest = UserEntity.fetchRequest()
        userRequest.predicate = NSPredicate(format: "id == %@", currentUser.id.uuidString)
        
        let jokeEntity = NSEntityDescription.entity(forEntityName: "JokeEntity", in: context)
        guard let userEntity = try? context.fetch(userRequest).first,
              let jokeEntity = jokeEntity
        else {
            return
        }
        
        let joke = NSManagedObject(entity: jokeEntity, insertInto: context)
        joke.setValue(data.id, forKey: "id")
        joke.setValue(data.content, forKey: "content")
        joke.setValue(Int16(data.category.rawValue), forKey: "category")
        userEntity.addToJokes(joke as! JokeEntity)
        
        do {
            try context.save()
            print(">>> 아무말 저장 완료!! : \(#function)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchWithPredicate(currentUser: User, currentCategory: Category) -> [Joke] {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 Joke data들을 가져오세요.
        // 1. 우선 currentUser, CurrentCategory 파라미터를 사용하지 말고, 모든 Joke 데이터를 return 해보세요.
        // 2. 나중에 User와 Relationship을 설정하여 Joke를 저장한 경우, 그때 NSPredicate를 활용하여 원하는 Joke들을 가져옵니다.
        // ---------------------------------------------------------------------------------------------------------//

        // ---------------------------------------------------------------------------------------------------------//
        // 설정해야 하는 NSPredicate 조건은 두 가지 입니다.
        // 1. 현재 선택된 User - currentUser 파라미터 활용
        // 2. 현재 선택된 Category - currentCategory 파라미터 활용
        // 위 두 가지를 만족하는 데이터들만 가져올 수 있도록 NSPredicate를 만들어보세요.
        // ---------------------------------------------------------------------------------------------------------//
        
//        return Joke.sampleJokes // 샘플 데이터입니다. CoreData에서 받아올 수 있도록 변경해보세요.
        
        let userRequest = UserEntity.fetchRequest()
        userRequest.predicate = NSPredicate(format: "id == %@", currentUser.id.uuidString)
        
        guard let userEntity = try? context.fetch(userRequest).first
        else {
            return []
        }
        
        let jokeRequest = JokeEntity.fetchRequest()
        jokeRequest.predicate = NSPredicate(format: "category == %@ && user == %@", String(currentCategory.rawValue), userEntity)
        
        guard let jokeEntities = try? context.fetch(jokeRequest) 
        else {
            return []
        }
        
        let jokes = jokeEntities.map { jokeEntity in
            let joke = Joke(
                id: jokeEntity.id!,
                content: jokeEntity.content!,
                category: Category(rawValue: Int(jokeEntity.category))!
            )
            
            return joke
        }
        
        print(">>> 아무말 페칭 완료!! : \(#function)")
        return jokes
    }
    
    func updateCoreData(_ data: Joke) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 특정 Joke data를 업데이트하세요.
        // ---------------------------------------------------------------------------------------------------------//
        let jokeRequest = JokeEntity.fetchRequest()
        jokeRequest.predicate = NSPredicate(format: "id == %@", data.id.uuidString)
        
        guard let jokeEntity = try? context.fetch(jokeRequest).first else { return }
        jokeEntity.setValue(data.content, forKey: "content")
        
        do {
            try context.save()
            print(">>> 아무말 업데이트 완료!! : \(#function)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCoreData(_ data: Joke) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 특정 Joke data를 삭제하세요.
        // ---------------------------------------------------------------------------------------------------------//
        
        let jokeRequest = JokeEntity.fetchRequest()
        jokeRequest.predicate = NSPredicate(format: "id == %@", data.id.uuidString)
        
        guard let jokeEntity = try? context.fetch(jokeRequest).first,
              let userEntity = jokeEntity.user
        else {
            return
        }
        userEntity.removeFromJokes(jokeEntity)
        context.delete(jokeEntity)
        
        do {
            try context.save()
            print(">>> 아무말 삭제 완료!! : \(#function)")
        } catch {
            print(error)
        }
    }
}
