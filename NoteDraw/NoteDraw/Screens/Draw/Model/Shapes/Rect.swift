//
//  Ellipse.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by 18495524 on 6/2/21.
//

import UIKit

class Rect: Ellipse {
    
    override init(at position: CGPoint, color: UIColor, lineWidth: CGFloat) {
        super.init(at: position, color: color, lineWidth: lineWidth)
        tool = "rect"
    }
    
    override func render() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(getLineWidth())
        context.setStrokeColor(getColor().cgColor)
        
        let position = getPosition()
        let rect = CGRect(
            x: position.x - rX,
            y: position.y - rY,
            width: 2 * rX,
            height: 2 * rY
        )
        context.addRect(rect)
        
        context.strokePath()
    }
    
}
