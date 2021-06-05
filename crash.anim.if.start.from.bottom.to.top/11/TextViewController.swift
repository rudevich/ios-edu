//
//  ViewController.swift
//  11
//
//  Created by 18495524 on 5/20/21.
//

import UIKit

class TextViewController: UIViewController {

    lazy var texts:UITextView = {
        let tv = UITextView(frame: UIScreen.main.bounds)
        tv.text = """
        Такой
        вот длинный,
        длинный-длинный
        текстовый блок
        
        Привет
        """
        tv.backgroundColor = .blue
        tv.textColor = .yellow
        tv.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        return tv
    }()
    
    lazy var button:UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.setTitle("hello", for: .normal)
        button.addTarget(self, action: #selector(timerStart), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    
    lazy var aniButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        button.setTitle("hello", for: .normal)
        button.addTarget(self, action: #selector(setCoreAnim), for: .touchUpInside)
        button.backgroundColor = .purple
        return button
    }()
    
    @objc func setCoreAnim() {
        aniButton.layer.removeAllAnimations()
        let a = CABasicAnimation(keyPath: "opacity")
        a.fromValue = 1
        a.toValue = 0.4
        a.autoreverses = true
        a.duration = 2
        a.repeatCount = .infinity
//        a.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        aniButton.layer.add(a, forKey: "firstAnimation")
//        button.layer.removeAnimation(forKey: "firstAnimation")
    }
    
    lazy var aniKeyButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 50))
        button.setTitle("hello", for: .normal)
        button.addTarget(self, action: #selector(setKeyAnim), for: .touchUpInside)
        button.backgroundColor = .lightGray
        return button
    }()
    
    @objc func setKeyAnim() {
        aniKeyButton.layer.removeAllAnimations()
        let a = CAKeyframeAnimation(keyPath: "position")
        let ar = [NSValue(cgPoint: CGPoint(x: 100,y: 300)), NSValue(cgPoint: CGPoint(x: 10,y: 40)), NSValue(cgPoint: CGPoint(x: 200,y: 40)), NSValue(cgPoint: CGPoint(x: 100,y: 300))]
        a.values = ar
        a.duration = 4
        a.autoreverses = true
        a.repeatCount = .infinity
        aniKeyButton.layer.add(a, forKey: "fist")
    }
    
    lazy var aniGroupButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y:380, width: 100, height: 50))
        button.setTitle("hello", for: .normal)
        button.addTarget(self, action: #selector(setGroupAnim), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    @objc func setGroupAnim() {
        let a = CAAnimationGroup()
        
        let b = CAKeyframeAnimation(keyPath: "position")
        b.values = [[100,300], [10,40], [200, 40], [100, 300]]
        b.duration = 4
        
        let c = CABasicAnimation(keyPath: "opacity")
        c.fromValue = 1
        c.toValue = 0.4
        c.duration = 2
        c.beginTime = b.duration
        
        a.animations = [b, c]
        a.duration = b.duration + c.duration
        a.autoreverses = true
        aniGroupButton.layer.add(a, forKey: "sdfsdf")
    }
    
//    lazy var aniTransButton:UIButton = {
//        let button = UIButton(frame: CGRect(x: 100, y:380, width: 100, height: 50))
//        button.setTitle("hello", for: .normal)
//        button.addTarget(self, action: #selector(setTransitionAnim), for: .touchUpInside)
//        button.backgroundColor = .black
//        return button
//    }()
//
//    @objc func setTransitionAnim() {
//        let v = ViewController()
//        let a = CATransition()
//        a.duration = 4
//        a.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        a.type = CATransitionType.push
//
//        navigationController?.view.layer.add(a, forKey: "sdf")
//        navigationController?.pushViewController(v, animated: false)
//    }
    
    
    var dir = 1;
    @objc func updateButton() {
        
        let old = button.center
//        button.center = CGPoint(x: old.x + 10, y: old.y + 10)
        if (old.x > UIScreen.main.bounds.maxX) {
            dir = -1
        } else if (old.x < UIScreen.main.bounds.minX) {
            dir = 1
        }
        button.center.x = CGFloat(Double(old.x) + Double(dir * 10))
        
    }
    var timer: Timer?
    @objc func timerStart() {
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateButton), userInfo: nil, repeats: true)
        } else {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        
        
        view.addSubview(texts)
        view.addSubview(button)
        view.addSubview(aniButton)
        view.addSubview(aniKeyButton)
        view.addSubview(aniGroupButton)
    }


}

