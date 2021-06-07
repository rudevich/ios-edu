//
//  Canvas.swift
//  freedraw
//
//  Created by 18495524 on 6/1/21.
//

import UIKit

class CanvasView: UIView {
    weak var delegate: FirstViewController?
    var shapes = Shapes()
    private var loadedImageView: UIImageView?
    private var currentColor: UIColor = .green
    private var currentTool: String = "line"
    private var currentLineWidth: CGFloat = 5
    
    func undo() {
        shapes.pop()
        setNeedsDisplay()
    }
    
    func save() {
        self.delegate?.navigationController?.popViewController(animated: true)
        self.delegate?.saveImage(self.asImage())
        clear()
    }
    
    func clear() {
        shapes.clear()
        setNeedsDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// set/gettable
extension CanvasView {
    func setColor(_ color: UIColor?) {
        currentColor = color ?? .red
    }
    func setTool(_ tool: String?) {
        currentTool = tool ?? "freedraw"
        print(currentTool)
    }
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

// Drawable
extension CanvasView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: self) else { return }
        start(p)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: self) else { return }
        paint(p)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: self) else { return }
        finish(p)
    }
    
    func start(_ p: CGPoint) {
        shapes.push(at: p, color: currentColor, lineWidth: currentLineWidth, tool: currentTool)
    }
    
    func paint(_ p: CGPoint) {
        guard shapes.last != nil else { return }
        if let redrawRect = shapes.last?.paint(p) {
            setNeedsDisplay(redrawRect)
        } else {
            setNeedsDisplay()
        }
    }
    
    func finish(_ p: CGPoint) {
        paint(p)
    }
    
    func render(_ shape: Shape) {
        shape.render()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        
        loadImage(self.delegate!.selectedImage)
        shapes.render()
    }
}

// Preloadable
extension CanvasView {
    // TODO cache for image layer
    func loadImage(_ img: UIImage?) {
        guard img != nil else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if self.loadedImageView == nil {
            self.loadedImageView = UIImageView(image: img!)
            self.loadedImageView?.frame = self.frame
            self.loadedImageView?.contentMode = .scaleAspectFit // scaleAspectFill
            print("Is Image preloaded:", self.loadedImageView != nil)
        }
        self.loadedImageView?.layer.render(in: context)
    }
    
    func preloadImageUsingLayer(_ img: UIImage?) {
        guard img != nil else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let imgSize = CGSize(width: img!.size.width, height: img!.size.height)
        let imgRect = CGRect(origin: .zero, size: imgSize)
        let cgImage = img!.cgImage!
        let layer = CGLayer(context, size: imgSize, auxiliaryInfo: .none)
        layer?.context?.translateBy(x: 0, y: img!.size.height)
        layer?.context?.scaleBy(x: 1.0, y: -1.0)

        layer?.context?.draw(cgImage, in: imgRect)
        context.draw(layer!, in: imgRect)
    }
}
