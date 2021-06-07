//
//  CollectionViewModel.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by Владислав Галкин on 04.06.2021.
//

import UIKit

struct DrawViewModel {

    var modelTableColor: [UIColor] = [.red, .black, .blue, .brown, .cyan, .darkGray, .systemFill, .green, .magenta, .orange, .purple, .yellow, .systemPink, .systemTeal]
    
    let modelCollectionShapes = [UIImage(systemName: "minus"), UIImage(systemName: "app"), UIImage(systemName: "rectangle"), UIImage(systemName: "scribble"),UIImage(systemName: "oval"),UIImage(systemName: "triangle")]
    
    let availableTools = ["line", "square", "rect", "freedraw", "ellipse", "triangle"]
}
