//
//  FetchResultsController.swift
//  NoteDraw
//
//  Created by 18495524 on 7/29/21.
//

import CoreData
import UIKit

class FetchImagesResultsController: NSFetchedResultsController<Images> {
    weak var collectionView: UICollectionView?
    var context = Container.shared.coreDataStack.backgroundContext
    
    func getImage(at index: IndexPath) -> Images {
        return self.object(at: index)
    }
    
    func updateImage(at index: IndexPath, title: String?, image: UIImage?) {
        let imageEntity = self.object(at: index)
        imageEntity.title = title
        if (image !== nil) {
            imageEntity.data = image?.pngData()
        }
        imageEntity.date = Date()
        try? self.managedObjectContext.save()
        print("updated:", imageEntity.title)
    }
    
    func insertImage(title: String?, image: UIImage?) {
        let imageEntity = Images(context: context)
        imageEntity.title = title
        imageEntity.data = image?.pngData()
        imageEntity.date = Date()
        try? self.managedObjectContext.save()
        print("inserted:", imageEntity.title)
    }
    
    func removeImage(at index: IndexPath) {
        let imageEntity = self.object(at: index)
        self.managedObjectContext.delete(imageEntity)
        try? self.managedObjectContext.save()
    }
    
    func deleteAllImages(_ completion: (()->Void)?) {
        Container.shared.coreDataStack.deleteAll(entityName: "Images")
        try? self.performFetch()
        completion?()
    }
    
    //    func addBulkImages() {
    //        let bulkImages: [UIImage?] = [
    //            UIImage(named: "file1.png"),
    //            UIImage(named: "file2.png"),
    //            UIImage(named: "file3.png"),
    //            UIImage(named: "file4.png"),
    //            UIImage(named: "file5.png"),
    //            UIImage(named: "file6.png"),
    //            UIImage(named: "file7.png"),
    //            UIImage(named: "file8.png"),
    //        ]
    //        for (i, image) in bulkImages.enumerated() {
    //            let imageEntity = Images(context: coreDataStack.backgroundContext)
    //            imageEntity.title = "Clip \(i)"
    //            imageEntity.data = image?.pngData()
    //            imageEntity.date = Date()
    //            try? coreDataStack.backgroundContext.save()
    //        }
    //    }
}


