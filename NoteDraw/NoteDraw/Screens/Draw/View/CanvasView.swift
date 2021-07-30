//
//  CanvasView.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

class CanvasView: UIView {
    weak var delegate: HomeViewController?
    var image: UIImage?
    var shapes = Shapes()
    private var loadedImageView: UIImageView?
    private var currentColor: UIColor = .cyan
    private var currentTool: String = "line"
    private var currentLineWidth: CGFloat = 5
    
    func undo() {
        shapes.pop()
        setNeedsDisplay()
    }
    
    func save() {
        self.delegate?.navigationController?.popViewController(animated: true)
        self.delegate?.saveImageWithTitle(self.asImage())
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
        currentColor = color ?? .cyan
    }
    func setTool(_ tool: String?) {
        currentTool = tool ?? "freedraw"
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
        guard let p = touches.first?.location(in: self), event?.allTouches?.count == 1 else { return }
        start(p)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: self), event?.allTouches?.count == 1 else { return }
        paint(p)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: self), event?.allTouches?.count == 1 else { return }
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
        
        loadImage(self.image)
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
            self.loadedImageView = UIImageView(image: img)
            self.loadedImageView?.contentMode = .center
            print("Is Image preloaded:", self.loadedImageView != nil)
        }
        self.loadedImageView?.layer.render(in: context)
    }
}

