//
//  AppDelegate.swift
//  colorcontur
//
//  Created by 18495524 on 7/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let root = LocalListViewController(dataModel: LocalImagesDataModel(), collectionView: CollectionView())
        Router.start(viewControllers: [
            "root": root,
            "local-list": root,
            "remote-list": RemoteListViewController(),
            "draw": DrawViewController(),
            "coloring": ColoringViewController()
        ])
        
        guard let nc = Router.route?.nc else { return false }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
    }

}

extension UINavigationController {
  func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
    var vcs = viewControllers
    vcs[vcs.count - 1] = viewController
    setViewControllers(vcs, animated: animated)
  }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
