//
//  Ellipse.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by 18495524 on 6/2/21.
//

import UIKit

class Line: Freedraw {
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
    var minX: CGFloat = CGFloat.infinity
    var minY: CGFloat = CGFloat.infinity
    
    override init(at position: CGPoint, color: UIColor, lineWidth: CGFloat) {
        super.init(at: position, color: color, lineWidth: lineWidth)
        tool = "line"
    }
    
    override func addPoint(_ p: CGPoint) {
        points[0] = p
    }
    
    override func getRedrawRect(_ currentPoint: CGPoint) -> CGRect {
        let position = getPosition()
        let lineWidth = getLineWidth()
        let minX = min(position.x, points[0].x) - lineWidth
        let minY = min(position.y, points[0].y) - lineWidth
        let maxX = max(position.x, points[0].x) + lineWidth
        let maxY = max(position.y, points[0].y) + lineWidth
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
