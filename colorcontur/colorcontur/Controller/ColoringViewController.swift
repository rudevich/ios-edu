//
//  ViewController.swift
//  colorcontur
//
//  Created by 18495524 on 7/9/21.
//

import UIKit
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins

class ColoringViewController: UIViewController {
    
    typealias ShapesType = [[CGPoint]]
    
    var detectedShapes: [CAShapeLayer] = []
    
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        let currentImage = Router.route?.getCurrentImage()
        let contentSize = currentImage?.size ?? .zero
        iv.frame = CGRect(x: 0, y: 0, width: contentSize.width, height:contentSize.height)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .cyan
        return iv
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        print(Router.route?.getCurrentImage())
        let currentImage = Router.route?.getCurrentImage()
        let contentSize = currentImage?.size
        sv.delegate = self
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .purple
        sv.contentSize = contentSize ?? .zero
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addColorHere))
        tap.numberOfTapsRequired = 1
        tap.isEnabled = true
        tap.cancelsTouchesInView = false
        sv.addGestureRecognizer(tap)
        
        return sv
    }()
    
    @objc func addColorHere(sender: UITapGestureRecognizer) {
        let p = sender.location(in: imageView)
        for shape in detectedShapes {
            if (shape.path?.contains(p) as! Bool) {
                shape.fillColor = UIColor.blue.cgColor
            }
        }
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 2
        scrollView.zoomScale = minScale
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detect contours"
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
        updateConstraints()
    }
    
    func updateConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo:view.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detectedShapes.removeAll()
        clearSubviews()
        detectContours()
    }
    
    func clearSubviews() {
        imageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    // MARK: Countours detection
    
    func detectContours() {
        guard let sourceImage = Router.route?.getCurrentImage() else { return }
        var inputImage = CIImage.init(cgImage: sourceImage.cgImage!)
        let context = CIContext()
        let contourRequest = VNDetectContoursRequest(completionHandler: handleDetectedContours)
        contourRequest.revision = VNDetectContourRequestRevision1
        contourRequest.contrastAdjustment = 1.0
        contourRequest.maximumImageDimension = 512
        
        do {
            let noiseReductionFilter = CIFilter.gaussianBlur()
            noiseReductionFilter.radius = 0.5
            noiseReductionFilter.inputImage = inputImage

            let blackAndWhite = BWFilter()
            blackAndWhite.inputImage = noiseReductionFilter.outputImage!
            let filteredImage = blackAndWhite.outputImage!
//                    let monochromeFilter = CIFilter.colorControls()
//                    monochromeFilter.inputImage = noiseReductionFilter.outputImage!
//                    monochromeFilter.contrast = 20.0
//                    monochromeFilter.brightness = 4
//                    monochromeFilter.saturation = 50
//                    let filteredImage = monochromeFilter.outputImage!

            inputImage = filteredImage
//            if let cgimg = context.createCGImage(filteredImage, from: filteredImage.extent) {
//                self.preProcessImage = UIImage(cgImage: cgimg)
//            }
        }

        let requestHandler = VNImageRequestHandler.init(ciImage: inputImage, options: [:])

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([contourRequest])
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    func handleDetectedContours(request: VNRequest?, error: Error?) {
        guard let sourceImage = Router.route?.getCurrentImage() else { return }

        let contoursObservation = request?.results?.first as! VNContoursObservation
        print("Detected contours count:", contoursObservation.contourCount)
        
        let path = contoursObservation.normalizedPath
        
        let shapes = filterDetectedContours(for: path)
        print("Filtered contrours:", shapes.count)
        
        DispatchQueue.main.sync {
            drawContours(for: shapes)
        }
    }
    
    func filterDetectedContours(for path: CGPath) -> ShapesType {
        var shapes: ShapesType = []
        path.applyWithBlock { element in
            var point = element.pointee.points.pointee
//            if (point.x > 0.99 || point.x < 0.01 || point.y > 0.99 || point.y < 0.01) {
//                return
//            }
            if (point.x > 0.99) {
                point.x = 1.0
            } else if (point.x < 0.01) {
                point.x = 0.0
            }
            if (point.y > 0.99) {
                point.y = 1.0
            } else if (point.y < 0.01) {
                point.y = 0.0
            }
            switch element.pointee.type
            {
            case .closeSubpath:
                break
            case .moveToPoint:
                shapes.append([])
                shapes[shapes.count - 1].append(point)
            case .addLineToPoint:
                if (shapes.count > 0) {
                    shapes[shapes.count - 1].append(point)
                }
            default:
              break
            }
        }
        return shapes
    }
    
    public func drawContours(for shapes: ShapesType) {
        var i = 0
        for shapePoints in shapes {
            let path = mutatePathFrom(points: shapePoints, to: imageView.bounds.size)
            let layer = CAShapeLayer()
            layer.path = path
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = UIColor.red.cgColor
            
            imageView.layer.addSublayer(layer)
            detectedShapes.append(layer)
            i += 1
        }
    }
    
    func mutatePathFrom(points: [CGPoint], to size: CGSize) -> CGPath {
        let path = CGMutablePath()
        let newPoints = points.map { point in
            return CGPoint(x: point.x * size.width, y: (1 - point.y) * size.height)
        }
        path.addLines(between: newPoints)
        path.closeSubpath()
        return path as CGPath
    }
    
    func pathFrom(points: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        path.addLines(between: points)
        path.closeSubpath()
        return path as CGPath
    }

    func centerScrollViewContent(_ scrollView: UIScrollView) {
        let contentWidth = scrollView.contentSize.width
        let contentHeight = scrollView.contentSize.height
        let boxWidth = scrollView.bounds.width
        let boxHeight = scrollView.bounds.height
        
        let offsetX = boxWidth == 0 ? abs(boxWidth - contentWidth) * 0.5 : max((boxWidth - contentWidth) * 0.5, 0)
        let offsetY = boxHeight == 0 ? abs(boxHeight - contentHeight) * 0.5 : max((boxHeight - contentHeight) * 0.5, 0)
        
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}

extension ColoringViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerScrollViewContent(scrollView)
    }
    
}


class BWFilter: CIFilter {
    var inputImage: CIImage?
    
    override public var outputImage: CIImage! {
        get {
            if let inputImage = self.inputImage {
                let args = [inputImage as AnyObject]
                
                let callback: CIKernelROICallback = {
                (index, rect) in
                    return rect.insetBy(dx: -1, dy: -1)
                }
                
                return createCustomKernel().apply(extent: inputImage.extent, roiCallback: callback, arguments: args)
            } else {
                return nil
            }
        }
    }

    
    func createCustomKernel() -> CIKernel {
        return CIColorKernel(source:
            "kernel vec4 replaceWithBlackOrWhite(__sample s) {" +
                "if (s.r > 0.25 && s.g > 0.25 && s.b > 0.25) {" +
                "    return vec4(0.0,0.0,0.0,1.0);" +
                "} else {" +
                "    return vec4(1.0,1.0,1.0,1.0);" +
                "}" +
            "}"
            )!
       
    }
}
