//
//  ViewController.swift
//  13
//
//  Created by 18495524 on 5/24/21.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var threeStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(three)
    }
    
    lazy var ground: CALayer = {
        let dim = 100
        let ret = CALayer()
        ret.name = "ground"
        ret.backgroundColor = UIColor.yellow.cgColor
        ret.cornerRadius = CGFloat(dim / 2)
        ret.frame = CGRect(
            x: 0,
            y: 0,
            width: dim, height: dim
        )
        ret.position = CGPoint(x: Int(view.frame.width) / 2 - dim / 2, y: Int(view.frame.height) / 2 - dim / 2)
        ret.anchorPoint = CGPoint.zero
        return ret
    }()
    
    lazy var seed: CALayer = {
        let dim = 20
        let ret = CALayer()
        ret.name = "seed"
        ret.backgroundColor = UIColor.brown.cgColor
        ret.cornerRadius = CGFloat(dim / 2)
        ret.opacity = 0
        ret.frame = CGRect(
            x: 0,
            y: 0,
            width: dim, height: dim
        )
        ret.anchorPoint = CGPoint(x: 0.5, y: 1)
        ret.position = CGPoint(x: Int(view.frame.width) / 2, y: Int(view.frame.height) - 4 * dim)
        
        return ret
    }()
    
    lazy var krona: kronaLayer = {
        let ret = kronaLayer()
        ret.name = "krona"
        ret.backgroundColor = UIColor.green.cgColor
        ret.cornerRadius = CGFloat(300 / 2)
        ret.frame = CGRect(
            x: 0,
            y: 0,
            width: 0, height: 0
        )
        
        return ret
    }()
    
    lazy var three: UIView = {
        let ret = UIView(frame: view.frame)
        
        ret.center = view.center
        ret.backgroundColor = .clear
//        ret.addTarget(self, action: #selector(start), for: .touchUpInside)
        let start = UITapGestureRecognizer(target: self, action: #selector(start))
        
        ret.layer.addSublayer(ground)
        ret.addGestureRecognizer(start)
        return ret
    }()
    
    
    
    @objc func start(recognizer: UITapGestureRecognizer) {
        let p = recognizer.location(in: view)
        if (!threeStarted && nil != ground.hitTest(p)) {
            groundDown(p)
        }
        if (nil != krona.hitTest(p)) {
            growApple(p)
        }
    }
    
    func growApple(_ p: CGPoint) {
        let apple = CALayer()
        let r = Int.random(in: 10...40)
        apple.backgroundColor = UIColor.red.cgColor
        apple.frame = CGRect(origin: CGPoint(x: CGFloat(Double(p.x) - Double(r)/2), y: CGFloat(Double(p.y) - Double(r)/2)), size: CGSize(width: r, height: r))
        apple.cornerRadius = CGFloat(r/2)
        three.layer.addSublayer(apple)
    }
    
    func startSeedGrowing() {
        three.layer.addSublayer(seed)
        
        
        UIView.animate(withDuration: 1, animations: {
            self.three.backgroundColor = UIColor.orange
        })
        
        let opacity = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacity.toValue = 1
        opacity.duration = 1
        opacity.fillMode = CAMediaTimingFillMode.forwards;
        opacity.isRemovedOnCompletion = false;
        opacity.delegate = self;
        seed.add(opacity, forKey: "seedPlanted")
        
        let transform = CABasicAnimation(keyPath: #keyPath(CALayer.bounds))
        transform.toValue = CGRect(x: 10, y: 10, width: 40, height: 300)
        transform.duration = 1
        transform.fillMode = CAMediaTimingFillMode.forwards;
        transform.isRemovedOnCompletion = false;
        
        
        transform.delegate = self;
        
        seed.add(transform, forKey: "seedGrowed")
    }
    
    func startkronaGrowing() {
        krona.position = CGPoint(x: seed.frame.minX + 10, y: seed.frame.minY - 200)
        three.layer.addSublayer(krona)
        
        let a = CABasicAnimation(keyPath: #keyPath(CALayer.bounds))
        a.toValue = CGRect(x: 0, y: 0, width: 300, height: 300)
        a.duration = 1;
        a.fillMode = CAMediaTimingFillMode.forwards;
        a.isRemovedOnCompletion = false;
        a.delegate = self;
        krona.add(a, forKey: "kronaGrowed")
    }
    
    func animationDidStart(_ a: CAAnimation) {
        threeStarted = true;
    }
    
    func animationDidStop(_ a: CAAnimation, finished flag: Bool) {
        switch a {
            case ground.animation(forKey: "groundDown"):
                groundDownFinished()
                startSeedGrowing()
                break;
            case seed.animation(forKey: "seedPlanted"):
                print("seed planted")
                break;
            case seed.animation(forKey: "seedGrowed"):
                print("seed growed")
                startkronaGrowing()
                break;
            case krona.animation(forKey: "kronaGrowed"):
                print("krona growed")
                krona.frame = CGRect(x: 10, y: 100, width: 300, height: 300)
                var i = 3
                while(i > 0) {
                    let p = CGPoint(
                        x: krona.frame.minX + 70 + CGFloat.random(in: 0...CGFloat(i * 50)),
                        y: krona.frame.minY + 70 + CGFloat.random(in: 0...CGFloat(i * 50))
                    )
                    if (!krona.contains(p)) {
                        continue
                    } else {
                        growApple(p)
                    }
                    i -= 1
                }
                break;
            default:
                print("no such animation")
        }
    }
    
    func groundDown(_ p: CGPoint) {
        let bottomAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        bottomAnimation.toValue = CGPoint(x: 0, y: view.frame.height - 100)
        bottomAnimation.beginTime = 0
        
        let boundsAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.bounds))
        boundsAnimation.toValue = CGRect(
            x: 0, y: 0,
            width: view.frame.width, height: ground.bounds.width
        )
        boundsAnimation.beginTime = 0
        
        let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerAnimation.toValue = 0
        cornerAnimation.beginTime = 0

        let group = CAAnimationGroup()
        group.animations = [bottomAnimation, cornerAnimation, boundsAnimation]
        group.duration = 1
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.fillMode = CAMediaTimingFillMode.forwards;
        group.isRemovedOnCompletion = false;
        group.delegate = self
        
        ground.add(group, forKey: "groundDown")
    }
    
    func groundDownFinished() {
        print("ground finished")
        ground.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 100)
        ground.cornerRadius = 0
        let text = UILabel()
        text.text = "touch krona to grow an apple"
        text.frame = CGRect(x: 0, y: self.view.frame.height - 70, width: self.view.frame.width, height: 40)
        text.textAlignment = .center
        view.addSubview(text)
    }

}

class kronaLayer: CALayer {
    private func isPointIn(_ x: CGFloat, _ y:CGFloat, _ radius: CGFloat) -> Bool {
        let cx = (self.frame.maxX - self.frame.minX) / 2
        let cy = (self.frame.maxY - self.frame.minY) / 2
        let ret = sqrt(
            (cx - x) * (cx - x)
            +
            (cy - y) * (cy - y)
        )
        print(ret, radius)
        return ret < radius;
    }
    
    override func contains(_ p: CGPoint) -> Bool {
        return isPointIn(p.x, p.y, self.bounds.maxX / 2)
    }
    
}
