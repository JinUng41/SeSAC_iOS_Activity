//
//  JokeEntity+CoreDataProperties.swift
//  CoreData_Starter
//
//  Created by 김진웅 on 12/30/23.
//
//

import Foundation
import CoreData


extension JokeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JokeEntity> {
        return NSFetchRequest<JokeEntity>(entityName: "JokeEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var content: String?
    @NSManaged public var category: Int16
    @NSManaged public var user: UserEntity?

}

extension JokeEntity : Identifiable {

}
