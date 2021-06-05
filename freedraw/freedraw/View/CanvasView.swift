//
//  Canvas.swift
//  freedraw
//
//  Created by 18495524 on 6/1/21.
//

import UIKit

class CanvasView: UIView {
    var delegate: FirstViewController?
    private var shapes = [Shape]()
    private var currentColor: UIColor = .green
    private var currentTool: String = "line"
    private var currentLineWidth: CGFloat = 5
    
    func start(_ p: CGPoint) {
        let shape = Shape(at: p, color: currentColor, lineWidth: currentLineWidth, tool: currentTool)
        shapes.append(shape)
        shape.addPoint(p)
    }
    
    func undo() {
        shapes.popLast()
        setNeedsDisplay()
    }
    
    func save() {
        self.delegate?.navigationController?.popViewController(animated: true)
        self.delegate?.pickAnImage(self.asImage())
        clear()
    }
    
    func clear() {
        shapes.removeAll()
        setNeedsDisplay()
    }
    
    func paint(_ p: CGPoint) {
        guard shapes.last != nil else { return }
        
        switch shapes.last!.getTool() {
        case "line":
            paintByPoints(p)
        case "ellipse":
            paintEllipse(p)
        default:
            print("unexpected tool")
            paintByPoints(p)
            break
        }
        setNeedsDisplay()
    }
    
    func paintEllipse(_ p: CGPoint) {
        shapes.last?.updateCenter(p)
    }
    
    func paintByPoints(_ p: CGPoint) {
        let lastPoint = shapes.last?.lastPoint()
        shapes.last?.addPoint(p)
        
        let rect = calculateRectBetween(
            lastPoint: lastPoint ?? p,
            newPoint: p,
            shapes.last!.getLineWidth()
        )
        setNeedsDisplay(rect)
    }
    
    func finish(_ p: CGPoint) {
        paint(p)
    }
    
    func calculateRectBetween(lastPoint: CGPoint, newPoint: CGPoint, _ lineWidth: CGFloat) -> CGRect {
        let originX = min(lastPoint.x, newPoint.x) - (lineWidth / 2)
        let originY = min(lastPoint.y, newPoint.y) - (lineWidth / 2)

        let maxX = max(lastPoint.x, newPoint.x) + (lineWidth / 2)
        let maxY = max(lastPoint.y, newPoint.y) + (lineWidth / 2)

        let width = maxX - originX
        let height = maxY - originY

        return CGRect(x: originX, y: originY, width: width, height: height)
    }
    
    func renderByPoints(_ shape: Shape) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        for (i, p) in shape.getPoints().enumerated() {
            if (i == 0) {
                context.move(to: p)
            } else {
                context.addLine(to: p)
            }
        }
    }
    
    func renderEllipse(_ shape: Shape) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let points = shape.getPoints()
        let position = shape.getPosition()
        let rx = abs(points[1].x - points[0].x)
        let ry = abs(points[1].y - points[0].y)
        
        let rect = CGRect(
            x: position.x - rx,
            y: position.y - ry,
            width: 2 * rx,
            height: 2 * ry
        )
        context.addEllipse(in: rect)
    }
    
    func preloadImage(_ img: UIImage?) {
        guard img != nil else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let rect = CGRect(
            x: 0, y: 0,
            width: img!.size.width,
            height: img!.size.height
        )
        let sizes = CGSize(width: img!.size.width, height: img!.size.height)
        var cgImage = img!.cgImage!
        var layer = CGLayer(context, size: sizes, auxiliaryInfo: .none)
        layer?.context?.translateBy(x: 0, y: img!.size.height)
        layer?.context?.scaleBy(x: 1.0, y: -1.0)
        
        layer?.context?.draw(cgImage, in: rect)

        
//        UIImageView(image: img!).layer.render(in: context)
        context.draw(
            layer!,
            in:rect
        )
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        
        preloadImage(self.delegate!.selectedImage)
        
        for shape in shapes {
            context.setLineWidth(shape.getLineWidth())
            print("Color:", shape.getTool(), shape.getColor().cgColor.components)
            context.setStrokeColor(shape.getColor().cgColor)
            
            switch shape.getTool() {
            case "line":
                renderByPoints(shape)
            case "ellipse":
                renderEllipse(shape)
            default:
                renderByPoints(shape)
                break
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: nil) else { return }
        start(p)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: nil) else { return }
        paint(p)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: nil) else { return }
        finish(p)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CanvasView {
    func setColor(_ color: UIColor?) {
        currentColor = color ?? .green
    }
    func setTool(_ tool: String?) {
        currentTool = tool ?? "line"
        print(currentTool)
    }
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
