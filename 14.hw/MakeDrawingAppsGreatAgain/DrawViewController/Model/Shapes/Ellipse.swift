//
//  Ellipse.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by 18495524 on 6/2/21.
//

import UIKit

class Ellipse: Shape {
    private let tool = "ellipse"
    var rX: CGFloat = 0
    var rY: CGFloat = 0
    
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
    var minX: CGFloat = CGFloat.infinity
    var minY: CGFloat = CGFloat.infinity
    
    override init(at position: CGPoint, color: UIColor, lineWidth: CGFloat) {
        super.init(at: position, color: color, lineWidth: lineWidth)
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
        context.addEllipse(in: rect)
        
        context.strokePath()
    }
    override func paint(_ currentPoint: CGPoint) -> CGRect {
        updateRadiusX(currentPoint.x)
        updateRadiusY(currentPoint.y)
        let redrawRect = getRedrawRect(currentPoint)
        return redrawRect
    }
    
    func getRedrawRect(_ p: CGPoint) -> CGRect {
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
    
    func updateRadiusX(_ x: CGFloat) {
        rX = abs(getPosition().x - x)
    }
    
    func updateRadiusY(_ y: CGFloat) {
        rY = abs(getPosition().y - y)
    }
}
