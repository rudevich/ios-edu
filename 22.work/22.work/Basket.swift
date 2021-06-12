//
//  Basket.swift
//  22.work
//
//  Created by 18495524 on 6/11/21.
//

protocol ProtocolApple {
    func slice() -> Int
}

class Apple:ProtocolApple {
    func slice() -> Int {
        return 5
    }
}


import Foundation
class Basket {
    var basket:[ProtocolApple] = []
    func build(apple: ProtocolApple) {
        let apple = Apple()
        basket.append(apple)
        basket.append(apple)
    }
}



