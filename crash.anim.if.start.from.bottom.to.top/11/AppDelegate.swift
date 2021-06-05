//
//  AppDelegate.swift
//  11
//
//  Created by 18495524 on 5/20/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc1 = ViewController();
        let vc2 = TextViewController();
        let tb = UITabBarController()
        
        tb.viewControllers = [vc1, vc2]
        tb.selectedIndex = 1
        tb.selectedViewController = vc2
        
        vc1.tabBarItem = UITabBarItem(title: "one", image: .add, tag: 0)
        vc2.tabBarItem = UITabBarItem(title: "two", image: .remove, tag: 0)
        
        window?.rootViewController = tb
        window?.makeKeyAndVisible()
        
        return true
    }


}

