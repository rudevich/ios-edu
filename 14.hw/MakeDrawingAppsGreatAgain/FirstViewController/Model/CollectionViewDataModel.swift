//
//  CollectionViewDataModel.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by Вадим Аписов on 29.05.2021.
//

import UIKit

struct CollectionViewDataModel {
    var imagesArray: [UIImage?] = [
        UIImage(),
        UIImage(named: "file1.png"),
        UIImage(named: "file2.png"),
        UIImage(named: "file3.png"),
        UIImage(named: "file4.png"),
        UIImage(named: "file5.png"),
        UIImage(named: "file6.png"),
        UIImage(named: "file7.png"),
        UIImage(named: "file8.png"),
    ]
    var titlesArray: [String?] = ["New image"] + Array(repeating: "Untitled", count: 8)
}
