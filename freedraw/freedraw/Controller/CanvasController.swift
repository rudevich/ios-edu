//
//  ViewController.swift
//  freedraw
//
//  Created by 18495524 on 5/31/21.
//

import UIKit

class CanvasController: UIViewController {
    
    let canvas = CanvasView()
    
    lazy var buttonClear:UIButton = {
        let ret = UIButton()
        ret.backgroundColor = .red
        ret.setTitle("Clear", for: .normal)
        ret.addTarget(self, action: #selector(clear), for: .touchUpInside)
        return ret
    }()
    
    @objc func clear() {
        canvas.clear()
    }
    
    override func loadView() {
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(buttonClear)
        buttonClear.translatesAutoresizingMaskIntoConstraints = false
        buttonClear.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonClear.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonClear.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonClear.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
    }
    

}

