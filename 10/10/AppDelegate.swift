//
//  AppDelegate.swift
//  10. UIKit lection
//
//  Created by 18495524 on 5/19/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Override point for customization after application launch.
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

