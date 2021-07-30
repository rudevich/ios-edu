//
//  ScrollViewDelegate.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//
import UIKit

extension DrawViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.canvas
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerScrollViewContent(scrollView)
    }
    
}

// MARK: - ScrollView

extension DrawViewController {
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / canvas.bounds.width
        let heightScale = size.height / canvas.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 2
        scrollView.zoomScale = minScale
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
