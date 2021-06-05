//
//  AppDelegate.swift
//  17
//
//  Created by 18495524 on 6/4/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let networkService = NetworkService()
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController(networkService)
        vc.detailsViewController = DetailsViewController(networkService)
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
    }

}

