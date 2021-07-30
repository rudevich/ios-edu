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
    var defaultTitle: String {
        return "Clip"
    }
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest<Images>(entityName: "Images")
    }

    @NSManaged public var data: Data?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension Images : Identifiable {
}
