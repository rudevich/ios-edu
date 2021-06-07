//
//  Ellipse.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by 18495524 on 6/2/21.
//

import UIKit

class Triangle: Ellipse {
    private let tool = "triangle"
    
    override init(at position: CGPoint, color: UIColor, lineWidth: CGFloat) {
        super.init(at: position, color: color, lineWidth: lineWidth)
    }
    
    override func render() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(getLineWidth())
        context.setStrokeColor(getColor().cgColor)
        
        let position = getPosition()
        
        context.beginPath()
        context.move(to: CGPoint(x: position.x, y: position.y - rY))
        context.addLine(to: CGPoint(x: position.x + rX, y: position.y + rY))
        context.addLine(to: CGPoint(x: position.x - rX, y: position.y + rY))
        context.closePath()
        
        context.strokePath()
    }
    
    override func getRedrawRect(_ p: CGPoint) -> CGRect {
        let position = getPosition()
        let lineWidth = getLineWidth()
        let minX = position.x - rX - lineWidth
        let minY = position.y - rY - lineWidth
        let maxX = position.x + rX + lineWidth
        let maxY = position.y + rY + lineWidth
        self.minX = min(minX, self.minX)
        self.minY = min(minY, self.minY)
        self.maxX = max(maxX, self.maxX)
        self.maxY = max(maxY, self.maxY)
        return CGRect(
            x: self.minX, y: self.minY,
            width: self.maxX - self.minX, height: self.maxY - self.minY
        )
    }
    
}
