//
//  ViewController.swift
//  10
//
//  Created by 18495524 on 5/19/21.
//

import UIKit

extension UIColor {
    class func randomColor(_ randomAlpha: Bool = false) -> UIColor {
        let redValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let greenValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let blueValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let alphaValue = randomAlpha ? CGFloat(arc4random_uniform(255)) / 255.0 : 1;

        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
    }
}

class ViewController: UIViewController {
    let buttonRadius = 50.0
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(
            x: 0, y: 0,
            width: buttonRadius * 2, height: buttonRadius * 2
        )
        button.setTitle("o_O", for: .normal)
        button.setTitle("–.–", for: .highlighted)
        button.backgroundColor = .black
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.yellow, for: .normal)
        button.setTitleColor(.orange, for: .highlighted)
        button.layer.cornerRadius = CGFloat(buttonRadius)
        return button
    }()
    
    lazy var booble: BoobleView = {
        return BoobleView(buttonRadius, 100)
    }()
    
    @objc func buttonTap() {
        print("button: tapped")
    }
    
    @objc func boobleTap(sender: UITapGestureRecognizer) {
//        let point = sender.location(in: self.view)
        booble.setStrokeColor(UIColor.randomColor(false))
        print("booble: tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(button)
        view.addSubview(booble)
        
        let buttonTapped = UITapGestureRecognizer(target: self, action: #selector(buttonTap))
        button.addGestureRecognizer(buttonTapped)
        
        let boobleTapped = UITapGestureRecognizer(target: self, action: #selector(boobleTap))
        booble.addGestureRecognizer(boobleTapped)
        
        button.center = view.center;
        booble.center = view.center;
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func alert(_ msg: String) {
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        alert.addAction(.init(title: "okay", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }

}

