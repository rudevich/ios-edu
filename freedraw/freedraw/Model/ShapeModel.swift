//
//  ShapeModel.swift
//  freedraw
//
//  Created by 18495524 on 6/1/21.
//

import UIKit

class Shape {
    private var tool: String
    private var lineWidth: CGFloat
    private var color: UIColor
    private var points: [CGPoint]
    private var position: CGPoint
    
    init(at position: CGPoint, color: UIColor, lineWidth: CGFloat, tool: String?) {
        self.position = position
        self.color = color
        self.lineWidth = lineWidth
        self.tool = tool ?? "line"
        self.points = []
    }
}

extension Shape {
    
    func updateCenter(_ p: CGPoint) {
        if (points.count == 2) {
            points[1] = p
        } else {
            points.append(p)
        }
    }
    
    func addPoint(_ p: CGPoint) {
        points.append(p)
    }
    
    // informable
    func getPoints() -> [CGPoint] {
        return points
    }
    func getTool() -> String {
        return tool
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
    func lastPoint() -> CGPoint? {
        return points.last
    }
    func getBoundingRect() -> CGRect {
        var minX, minY, maxX, maxY: CGFloat
        minX = CGFloat.infinity; maxX = 0
        minY = CGFloat.infinity; maxY = 0
        self.points.forEach { point in
            if (point.x < minX) {
                minX = point.x
            }
            if (point.y < minY) {
                minY = point.y
            }
            if (point.x > maxX) {
                maxX = point.x
            }
            if (point.y > minY) {
                maxY = point.y
            }
        }
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}
