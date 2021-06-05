////
////  Canvas.swift
////  freedraw
////
////  Created by 18495524 on 6/1/21.
////
//
//import UIKit
//
//class CanvasView_layers: UIView {
//    private var shapes = [Shape]()
//    private var currentColor: UIColor = .green
//    private var currentLineWidth: CGFloat = 5
//    private var currentTool: String?
//    
//    func start(_ p: CGPoint) {
//        let shape = Shape(to: p, color: currentColor, lineWidth: currentLineWidth, tool: currentTool)
//        shape.addPoint(p)
//        shapes.append(shape)
//    }
//    
//    func draw(_ p: CGPoint) {
//        guard shapes.last != nil else { return }
//        
//        let lastPoint = shapes.last?.lastPoint()
//        shapes.last?.addPoint(p)
//        
//        let rect = calculateRectBetween(
//            lastPoint: lastPoint ?? p,
//            newPoint: p,
//            shapes.last!.getLineWidth()
//        )
//        setNeedsDisplay(rect)
//    }
//    
//    func finish(_ p: CGPoint) {
//        draw(p)
//    }
//    
//    func clear() {
//        shapes.removeAll()
//        setNeedsDisplay()
//    }
//    
//    func calculateRectBetween(lastPoint: CGPoint, newPoint: CGPoint, _ lineWidth: CGFloat) -> CGRect {
//        let originX = min(lastPoint.x, newPoint.x) - (lineWidth / 2)
//        let originY = min(lastPoint.y, newPoint.y) - (lineWidth / 2)
//
//        let maxX = max(lastPoint.x, newPoint.x) + (lineWidth / 2)
//        let maxY = max(lastPoint.y, newPoint.y) + (lineWidth / 2)
//
//        let width = maxX - originX
//        let height = maxY - originY
//
//        return CGRect(x: originX, y: originY, width: width, height: height)
//    }
//    
//    // idea about caching context https://stackoverflow.com/questions/13828633/dont-clear-the-context-before-drawing
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        UIGraphicsPushContext(context)
//        context.setLineCap(.round)
//        print("drawing started")
//        
//        for shape in shapes {
//            context.setLineWidth(shape.getLineWidth())
//            context.setStrokeColor(shape.getColor().cgColor)
//            
//            if let layer = shape.getLayer() {
//                let rect = shape.getBoundingRect()
//                context.draw(layer, at: CGPoint(x: rect.minX, y: rect.minY))
//                print("drawed: from layer")
//            } else {
//                for (i, p) in shape.getPoints().enumerated() {
//                    if (i == 0) {
//                        context.move(to: p)
//                    } else {
//                        context.addLine(to: p)
//                    }
//                }
//                print("drawed: point by point")
//            }
//        }
//        print("drawing finished")
//        context.strokePath()
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let p = touches.first?.location(in: nil) else { return }
//        start(p)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let p = touches.first?.location(in: nil) else { return }
//        draw(p)
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let p = touches.first?.location(in: nil) else { return }
//        finish(p)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        shapes.last?.saveLayer(context: context)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .white
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
