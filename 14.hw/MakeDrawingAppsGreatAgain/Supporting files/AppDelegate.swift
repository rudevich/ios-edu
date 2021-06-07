//
//  AppDelegate.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by Вадим Аписов on 29.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let firstVC = ConstructorController.createFirstViewController(dataModel: CollectionViewDataModel(), collectionView: MosaicCollectionView())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: firstVC)
        window?.makeKeyAndVisible()
        
        return true
    }
}

