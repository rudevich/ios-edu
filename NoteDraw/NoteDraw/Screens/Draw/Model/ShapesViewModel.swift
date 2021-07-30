//
//  ShapesViewModel.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

class Shapes {
    var completion: ((Bool) -> Void)?
    var last: Shape? {
        return shapes.last
    }
    var count: Int {
        return shapes.count
    }
    private var shapes = [Shape]() {
        didSet {
            completion?(!shapes.isEmpty)
        }
    }
    
    func push(at position: CGPoint, color: UIColor, lineWidth: CGFloat, tool: String?) {
        var shape: Shape {
            switch tool {
                case "ellipse":
                    return Ellipse(at: position, color: color, lineWidth: lineWidth)
                case "rect":
                    return Rect(at: position, color: color, lineWidth: lineWidth)
                case "square":
                    return Square(at: position, color: color, lineWidth: lineWidth)
                case "triangle":
                    return Triangle(at: position, color: color, lineWidth: lineWidth)
                case "line":
                    return Line(at: position, color: color, lineWidth: lineWidth)
                default: // freedraw
                    return Freedraw(at: position, color: color, lineWidth: lineWidth)
            }
        }
        shapes.append(shape)
    }
    
    func pop() {
        shapes.removeLast()
    }
    
    func clear() {
        shapes.removeAll()
    }
    
    func render() {
        for shape in shapes {
            shape.render()
        }
    }
}
