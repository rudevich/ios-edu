//
//  ViewController.swift
//  20.Carthage
//
//  Created by 18495524 on 6/11/21.
//

import UIKit
import ColorRandom

class ViewController: UIViewController, CAAnimationDelegate {
    
    var currentColor: UIColor = ColorRandomGenerator.generate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorRandomGenerator.generate
        createAnimation()
    }
    
    func createAnimation() {
        currentColor = ColorRandomGenerator.generate
        view.layer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = currentColor.cgColor
        animation.duration = 1
        animation.delegate = self
        animation.repeatCount = 1
        view.layer.add(animation, forKey: "bgcolor")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag != false else { return }
        view.backgroundColor = currentColor
        createAnimation()
    }


}

