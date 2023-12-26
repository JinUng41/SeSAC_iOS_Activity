//
//  UserMO+CoreDataProperties.swift
//  CoreData_Starter
//
//  Created by 김진웅 on 12/27/23.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var jokeRelationship: NSSet?

}

// MARK: Generated accessors for jokeRelationship
extension UserMO {

    @objc(addJokeRelationshipObject:)
    @NSManaged public func addToJokeRelationship(_ value: JokeMO)

    @objc(removeJokeRelationshipObject:)
    @NSManaged public func removeFromJokeRelationship(_ value: JokeMO)

    @objc(addJokeRelationship:)
    @NSManaged public func addToJokeRelationship(_ values: NSSet)

    @objc(removeJokeRelationship:)
    @NSManaged public func removeFromJokeRelationship(_ values: NSSet)

}

extension UserMO : Identifiable {

}
