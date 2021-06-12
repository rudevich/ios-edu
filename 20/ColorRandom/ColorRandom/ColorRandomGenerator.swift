//
//  ColorRandom.swift
//  ColorRandom
//
//  Created by 18495524 on 6/11/21.
//

import UIKit

open class ColorRandomGenerator {
    public static var generate: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
