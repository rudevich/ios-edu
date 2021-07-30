//
//  ViewController.swift
//  colorcontur
//
//  Created by 18495524 on 7/9/21.
//

import UIKit

class RemoteListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Remote list"
        
        view.backgroundColor = .green
        
//        view.addSubview(pickImageButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraints()
    }
    
    func updateConstraints() {
//        NSLayoutConstraint.activate([
//            pickImageButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
//            pickImageButton.trailingAnchor.constraint(equalTo:view.centerXAnchor, constant: 100),
//            pickImageButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 0),
//            pickImageButton.bottomAnchor.constraint(equalTo:view.centerYAnchor, constant: 50),
//        ])
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



