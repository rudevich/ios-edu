

import UIKit

class Curve {
    var points: [CGPoint]
    private var lineWidth: CGFloat
    private var color: UIColor
    private var position: CGPoint
    
    init(at position: CGPoint) {
        self.position = position
        self.color = .white
        self.lineWidth = 4
        self.points = [position]
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
    
    func paint(_ currentPoint: CGPoint) -> CGRect {
        let redrawRect = getRedrawRect(currentPoint)
        addPoint(currentPoint)
        return redrawRect
    }
    
    func render() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(getLineWidth())
        context.setStrokeColor(getColor().cgColor)
        
        context.move(to: getPosition())
        for p in points {
            context.addLine(to: p)
        }
        
        context.strokePath()
    }
    
    func getRedrawRect(_ currentPoint: CGPoint) -> CGRect {
        guard let prevPoint = points.last else { return CGRect.zero }
        let originX = min(prevPoint.x, currentPoint.x) - (getLineWidth() / 2)
        let originY = min(prevPoint.y, currentPoint.y) - (getLineWidth() / 2)
        let maxX = max(prevPoint.x, currentPoint.x) + (getLineWidth() / 2)
        let maxY = max(prevPoint.y, currentPoint.y) + (getLineWidth() / 2)
        
        let width = maxX - originX
        let height = maxY - originY
        return CGRect(x: originX, y: originY, width: width, height: height)
    }
    
    func getPoints() -> [CGPoint] {
        return points
    }
    
    func lastPoint() -> CGPoint? {
        return points.last
    }
    
    func addPoint(_ p: CGPoint) {
        points.append(p)
    }
    
    func getBoundingRect() -> CGRect? {
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
