//
//  CDContainer.swift
//  NoteDraw
//
//  Created by 18495524 on 7/29/21.
//

import Foundation

final class Container {
    static let shared = Container()
    private init() {
    }
    
    lazy var coreDataStack = CoreDataStack(modelName: "Images")
}
