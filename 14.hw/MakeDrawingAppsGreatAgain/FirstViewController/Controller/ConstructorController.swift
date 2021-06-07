//
//  ConstructorController.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by Вадим Аписов on 01.06.2021.
//

import UIKit

class ConstructorController {
    static func createFirstViewController(dataModel: CollectionViewDataModel, collectionView: UICollectionView) -> FirstViewController {
        return FirstViewController(dataModel: dataModel, collectionView: collectionView)
    }
}
