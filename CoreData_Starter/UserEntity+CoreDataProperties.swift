//
//  UserEntity+CoreDataProperties.swift
//  CoreData_Starter
//
//  Created by 김진웅 on 12/26/23.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension UserEntity : Identifiable {

}
