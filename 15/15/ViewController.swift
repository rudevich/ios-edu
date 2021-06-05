//
//  ViewController.swift
//  15
//
//  Created by 18495524 on 5/26/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(MyCollectionView.self)
    }


}

extension ViewController: UICollectionViewDataSource {
    
}

extension ViewController: UICollectionViewDelegate {
    
}
