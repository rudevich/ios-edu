//
//  GradientView.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by Вадим Аписов on 06.06.2021.
//

import UIKit

final class GradientView: UIView {
    var colors = [UIColor]() {
        didSet {
            setupGradientColors(colors)
        }
    }
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    private func setupGradientColors(_ colors: [UIColor]) {
        gradientLayer.colors = colors.map { $0.cgColor }
    }
    
    convenience init(colors: [UIColor]) {
        self.init(frame: .zero)
        
        setupGradientColors(colors)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0, 0.25, 0.75, 1]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

