//
//  DrawViewModel.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

struct DrawViewModel {

    var colors: [UIColor] = [.cyan, .black, .blue, .brown, .red, .darkGray, .systemFill, .green, .magenta, .orange, .purple, .yellow, .systemPink, .systemTeal]
    
    let toolsIcons = [UIImage(systemName: "minus"), UIImage(systemName: "app"), UIImage(systemName: "rectangle"), UIImage(systemName: "scribble"),UIImage(systemName: "oval"),UIImage(systemName: "triangle")]
    
    let tools = ["line", "square", "rect", "freedraw", "ellipse", "triangle"]
    
    var defaultTool: Int {
        return 3 // freedraw
    }
    var defaultColor: UIColor {
        return colors[0]
    }
}

