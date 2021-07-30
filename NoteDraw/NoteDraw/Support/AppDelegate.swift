//
//  AppDelegate.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let stack = Container.shared.coreDataStack
        stack.load()
        
        let networkService = NetworkService()
    
        let homeScreen = HomeViewController(networkService: networkService)
        let nc = UINavigationController(rootViewController: homeScreen)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
    }


}

