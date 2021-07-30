//
//  Images+CoreDataProperties.swift
//  NoteDraw
//
//  Created by 18495524 on 7/29/21.
//
//

import Foundation
import CoreData


extension Images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest<Images>(entityName: "Images")
    }

    @NSManaged public var title: String?
    @NSManaged public var data: Data?

}

extension Images : Identifiable {

}
