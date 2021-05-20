//
//  Booble.swift
//  10
//
//  Created by 18495524 on 5/19/21.
//

import UIKit

final class BoobleView: UIView {
    var strokeWidth = 0.0;
    var buttonRadius = 0.0;
    var boobleRadius: Double {
        return buttonRadius + strokeWidth
    };
    var circleLayer = CAShapeLayer()
    
    init(_ buttonRadius:Double, _ strokeWidth: Double) {
        super.init(frame: .zero)
        self.buttonRadius = buttonRadius
        self.strokeWidth = strokeWidth
        let circlePath = UIBezierPath(
            arcCenter: .init(
                x: self.boobleRadius,
                y: self.boobleRadius
            ),
            radius: CGFloat(self.boobleRadius - strokeWidth / 2),
            startAngle: CGFloat(0),
            endAngle: CGFloat(Double.pi * 2),
            clockwise: true
        )

        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.orange.cgColor
        circleLayer.lineWidth = CGFloat(strokeWidth)

        self.layer.addSublayer(circleLayer)
        self.frame = CGRect(x: 0, y: 0,
                         width: boobleRadius * 2,
                         height: boobleRadius * 2)
    }
    
    public func setStrokeColor(_ color: UIColor) {
        circleLayer.strokeColor = color.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func isInBooble(_ x: CGFloat, _ y:CGFloat, _ radius: Double) -> Bool {
        let ret = sqrt(
            (Double(x) - boobleRadius) * (Double(x) - boobleRadius)
            +
            (Double(y) - boobleRadius) * (Double(y) - boobleRadius)
        )
        return ret < radius;
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return isInBooble(point.x, point.y, boobleRadius) && !isInBooble(point.x, point.y, buttonRadius)
    }
}
