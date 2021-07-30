//
//  Shape.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by 18495524 on 6/2/21.
//

import UIKit

class Shape {
    var tool: String?
    private var lineWidth: CGFloat
    private var color: UIColor
    private var position: CGPoint
    
    init(at position: CGPoint, color: UIColor, lineWidth: CGFloat) {
        self.position = position
        self.color = color
        self.lineWidth = lineWidth
        tool = nil
    }
    
    func getTool() -> String {
        return tool ?? "freedraw"
    }
    
    func getPosition() -> CGPoint {
        return position
    }
    
    func getLineWidth() -> CGFloat {
        return lineWidth
    }
    
    func getColor() -> UIColor {
        return color
    }
    
    func paint(_ currentPoint: CGPoint) -> CGRect {
        return CGRect.zero
    }
    
    func render() {
        
    }
}
