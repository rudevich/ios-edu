//
//  Store.swift
//  colorcontur
//
//  Created by 18495524 on 7/27/21.
//

import Foundation
import UIKit

protocol RouterProtocol {
    static func start(viewControllers vcs: [String: UIViewController])
}

class Router: RouterProtocol {

    // MARK: - statics
    private static var _route: Router?
    
    static var route: Router? {
        return _route
    }
    
    static func start(viewControllers vcs: [String: UIViewController]) {
        _route = route ?? Router(viewControllers: vcs)
    }

    // MARK: -
    var vcs: [String: UIViewController]?
    var nc: UINavigationController?
    var root: UIViewController?
    var currentImage: UIImage?

    // Initialization

    private init(viewControllers vcs: [String: UIViewController]) {
        guard let root = vcs["root"] else { return }
        self.vcs = vcs
        self.root = root
        self.nc = UINavigationController(rootViewController: root)
    }
}

// MARK: Router Storage
protocol RouterStorage {
    func setCurrentImage(_ image: UIImage?)
    func getCurrentImage() -> UIImage?
}

extension Router: RouterStorage {
    func setCurrentImage(_ image: UIImage?) {
        currentImage = image
    }
    
    func getCurrentImage() -> UIImage? {
        return currentImage
    }
}

// MARK: Router Routing

protocol RouterRouting {
    func push(_ screen: String, animated: Bool?)
    func replace(_ screen: String, animated: Bool?)
}

extension Router: RouterRouting {
    func push(_ screen: String, animated: Bool?) {
        guard let screen = vcs?[screen] else { return }
        nc?.pushViewController(screen, animated: animated ?? false)
    }
    
    func replace(_ screen: String, animated: Bool?) {
        guard let screen = vcs?[screen] else { return }
        nc?.replaceTopViewController(with: screen, animated: animated ?? false)
    }
}
