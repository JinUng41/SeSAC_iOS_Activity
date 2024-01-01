//
//  UserEntity+CoreDataProperties.swift
//  CoreData_Starter
//
//  Created by 김진웅 on 12/30/23.
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
    @NSManaged public var jokes: NSSet?

}

// MARK: Generated accessors for jokes
extension UserEntity {

    @objc(addJokesObject:)
    @NSManaged public func addToJokes(_ value: JokeEntity)

    @objc(removeJokesObject:)
    @NSManaged public func removeFromJokes(_ value: JokeEntity)

    @objc(addJokes:)
    @NSManaged public func addToJokes(_ values: NSSet)

    @objc(removeJokes:)
    @NSManaged public func removeFromJokes(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
