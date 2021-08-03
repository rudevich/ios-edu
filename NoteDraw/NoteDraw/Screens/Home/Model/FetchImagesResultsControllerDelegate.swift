//
//  FetchImagesResultsControllerDelegate.swift
//  NoteDraw
//
//  Created by 18495524 on 7/30/21.
//

import CoreData
import UIKit

extension FetchImagesResultsController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            collectionView?.insertItems(at: [[0,0]])
            break;
        case .update:
            if let indexPath = indexPath {
                collectionView?.reloadItems(at: [indexPath])
            }
            break;
        case .move:
            if let collectionView = collectionView {
                UIView.transition(with: collectionView,
                    duration: 0.35,
                    options: .transitionCrossDissolve,
                    animations: {
                        collectionView.reloadData()
                    }
                )
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                collectionView?.deleteItems(at: [indexPath])
            }
            break;
        default:
            print("frc didnt controll that action")
        }
    }
}

