//
//  Human+CoreDataProperties.swift
//  26
//
//  Created by 18495524 on 6/23/21.
//
//

import Foundation
import CoreData


extension Human {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Human> {
        return NSFetchRequest<Human>(entityName: "Human")
    }

    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var gender: Bool

}

extension Human : Identifiable {

}

