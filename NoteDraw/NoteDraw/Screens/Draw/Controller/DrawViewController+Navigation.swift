//
//  DrawControllerNavigation.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

// MARK: - Navigation
extension DrawViewController {
    func setupNavigation() {
        let undo = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(canvasUndo))
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(canvasSave))
        
        undo.isEnabled = false
        save.isEnabled = false
        
        canvas.shapes.completion = {
            undo.isEnabled = $0
            save.isEnabled = $0
        }
        
        navigationItem.rightBarButtonItems = [undo, save].reversed()
    }
    
    @objc private func canvasClear() {
        canvas.clear()
    }
    
    @objc private func canvasUndo() {
        canvas.undo()
    }
    
    @objc private func canvasSave() {
        canvas.save()
    }
}
