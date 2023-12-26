//
//  JokeMO+CoreDataProperties.swift
//  CoreData_Starter
//
//  Created by 김진웅 on 12/27/23.
//
//

import Foundation
import CoreData


extension JokeMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JokeMO> {
        return NSFetchRequest<JokeMO>(entityName: "Joke")
    }

    @NSManaged public var category: Int16
    @NSManaged public var content: String?
    @NSManaged public var id: UUID?
    @NSManaged public var userRelationship: UserMO?

}

extension JokeMO : Identifiable {

}
