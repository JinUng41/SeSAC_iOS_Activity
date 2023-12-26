//
//  UserListViewController+CoreDataCRUD.swift
//  CoreData_Starter
//

import Foundation
import CoreData

//MARK: - ⭐️ CoreData CURD 구현하기 ⭐️
extension UserListViewController: CoreDataManagable {
    func saveCoreData(_ data: User) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData에 User data를 저장하세요.
        // ---------------------------------------------------------------------------------------------------------//
        
        // 1. 관리자 누구세요? -> 요청이 들어와서 그런데 저랑 대화좀 합시다..
        let context = container.viewContext
        
        // 2. 특정 정보(User)에 대한 엔터티 찾기 -> User 목록표 찾기
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        // 3. 들어온 새로운 정보를 목록표에 작성
        guard let entity = entity else { return }
        let user = NSManagedObject(entity: entity, insertInto: context)
        user.setValue(data.id, forKey: "id")
        user.setValue(data.name, forKey: "name")
        
        // 4. 변화를 체크하고, 없으면 저장하지 않는다. (불필요한 행동)
        guard context.hasChanges else { return }
        
        // 5. 실제로 관리자가 저장하기
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    func fetchCoreData() -> [User] {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 모든 User data를 가져오세요.
        // ---------------------------------------------------------------------------------------------------------//
        
        // 1. 관리자 연락 -> 너? 나 좀 보자.
        let context = container.viewContext

        // 2. 유저 목록표 조회해야 돼 -> 요청 생성
        let request = NSFetchRequest<UserMO>(entityName: "User")
        
        do {
            // 3. 실제 관리자가 요청을 수행 -> 리턴 타입은 제네릭 인자 타입을 따른다.
            let users = try context.fetch(request)

            // 따라서 타입 캐스팅이 필요하다.
            guard let realUsers = users as? [User] else { return [] }
            
            // 4. 실제 원하는 타입을 리턴
            return realUsers
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    func updateCoreData(_ data: User) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 특정 User data를 업데이트하세요.
        // ---------------------------------------------------------------------------------------------------------//
        
    }
    
    func deleteCoreData(_ data: User) {
        // ---------------------------------------------------------------------------------------------------------//
        // 이 곳에서 CoreData의 특정 User data를 삭제하세요.
        // ---------------------------------------------------------------------------------------------------------//
        
    }
}
