////
////  ShapeModel.swift
////  freedraw
////
////  Created by 18495524 on 6/1/21.
////
//
//import UIKit
//
//class Shape_layers {
//    private var tool: String
//    private var lineWidth: CGFloat
//    private var color: UIColor
//    private var points: [CGPoint]
//    private var position: CGPoint
//    private var layer: CGLayer?
//    
//    init(to position: CGPoint, color: UIColor, lineWidth: CGFloat, tool: String?) {
//        self.position = position
//        self.color = color
//        self.lineWidth = lineWidth
//        self.tool = tool ?? "line"
//        self.points = []
//    }
//}
//
//extension Shape_layers {
//    func addPoint(_ p: CGPoint) {
//        points.append(p)
//    }
//    
//    func saveLayer(context: CGContext) {
//        let rect = getBoundingRect()
//        layer = CGLayer.init(context, size: CGSize(
//            width: rect.width,
//            height: rect.height
//        ), auxiliaryInfo: nil)
//    }
//    
//    // informable
//    func getPoints() -> [CGPoint] {
//        return points
//    }
//    func getLayer() -> CGLayer? {
//        return layer
//    }
//    func getTool() -> String {
//        return tool
//    }
//    func getPosition() -> CGPoint {
//        return position
//    }
//    func getLineWidth() -> CGFloat {
//        return lineWidth
//    }
//    func getColor() -> UIColor {
//        return color
//    }
//    func lastPoint() -> CGPoint? {
//        return points.last
//    }
//    func getBoundingRect() -> CGRect {
//        var minX, minY, maxX, maxY: CGFloat
//        minX = CGFloat.infinity; maxX = 0
//        minY = CGFloat.infinity; maxY = 0
//        self.points.forEach { point in
//            if (point.x < minX) {
//                minX = point.x
//            }
//            if (point.y < minY) {
//                minY = point.y
//            }
//            if (point.x > maxX) {
//                maxX = point.x
//            }
//            if (point.y > minY) {
//                maxY = point.y
//            }
//        }
//        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
//    }
//}
