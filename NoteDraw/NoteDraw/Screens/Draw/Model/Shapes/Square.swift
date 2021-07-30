//
//  Ellipse.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by 18495524 on 6/2/21.
//

import UIKit

class Square: Ellipse {
    
    override init(at position: CGPoint, color: UIColor, lineWidth: CGFloat) {
        super.init(at: position, color: color, lineWidth: lineWidth)
        tool = "square"
    }
    
    override func render() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(getLineWidth())
        context.setStrokeColor(getColor().cgColor)
        
        let position = getPosition()
        let rect = CGRect(
            x: position.x - rX,
            y: position.y - rX,
            width: 2 * rX,
            height: 2 * rX
        )
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rX / 3).cgPath
        context.addPath(path)
        context.closePath()
        
        context.strokePath()
    }
    
    override func paint(_ currentPoint: CGPoint) -> CGRect {
        updateRadiusX(currentPoint.x)
        let redrawRect = getRedrawRect(currentPoint)
        return redrawRect
    }
    
    override func getRedrawRect(_ p: CGPoint) -> CGRect {
        let position = getPosition()
        let lineWidth = getLineWidth()
        let minX = position.x - rX - lineWidth
        let minY = position.y - rX - lineWidth
        let maxX = position.x + rX + lineWidth
        let maxY = position.y + rX + lineWidth
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
