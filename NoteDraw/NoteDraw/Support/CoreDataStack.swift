//
//  CoreDataStack.swift
//  NoteDraw
//
//  Created by 18495524 on 7/29/21.
//

import Foundation
import CoreData

class CoreDataStack {
    private let container: NSPersistentContainer
    
    init(modelName: String) {
        let container = NSPersistentContainer(name: modelName)
        self.container = container
    }
    
    func load() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    func deleteAll(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? coordinator.execute(deleteRequest, with: backgroundContext)
    }
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    lazy var backgroundContext: NSManagedObjectContext = container.newBackgroundContext()
    
    var coordinator: NSPersistentStoreCoordinator {
        container.persistentStoreCoordinator
    }
}
