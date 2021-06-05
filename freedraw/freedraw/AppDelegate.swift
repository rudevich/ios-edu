//
//  AppDelegate.swift
//  freedraw
//
//  Created by 18495524 on 5/31/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CanvasController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

