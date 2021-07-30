//
//  Canvas.swift
//  freedraw
//
//  Created by 18495524 on 6/1/21.
//

import UIKit

class CanvasView: UIView {
    weak var router: Router?
    var completion: ((Bool) -> Void)?
    var curves = [Curve]() {
        didSet {
            completion?(!curves.isEmpty)
        }
    }
    private var loadedImageView: UIImageView?
    
    func undo() {
        curves.removeLast()
        setNeedsDisplay()
    }
    
    func save() {
        router?.setCurrentImage(self.asImage())
        clear()
    }
    
    func clear() {
        curves.removeAll()
        setNeedsDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// set/gettable
extension CanvasView {
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
        curves.append(Curve(at: p))
    }
    
    func paint(_ p: CGPoint) {
        guard curves.last != nil else { return }
        if let redrawRect = curves.last?.paint(p) {
            setNeedsDisplay(redrawRect)
        } else {
            setNeedsDisplay()
        }
    }
    
    func finish(_ p: CGPoint) {
        paint(p)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        for curve in curves {
            curve.render()
        }
    }
}
