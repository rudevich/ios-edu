//
//  ShowImageViewController.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by Вадим Аписов on 02.06.2021.
//

import UIKit

final class ShowImageViewController: UIViewController {
    private let image: UIImage
    private let imageName: String
    
    var completion: (() -> Void)?
    
    lazy private var imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.image = image
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    lazy private var editImageButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editImageButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var label: UILabel = {
        let label = UILabel()
        
        label.text = imageName
        label.font = UIFont(name: "Helvetica Neue", size: 23)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(editImageButton)
        view.addSubview(label)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let imageViewConstraints = [
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let buttonConstraints = [
            editImageButton.widthAnchor.constraint(equalToConstant: 40),
            editImageButton.heightAnchor.constraint(equalTo: editImageButton.widthAnchor),
            editImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            editImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ]
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    @objc private func editImageButtonTapped() {
        dismiss(animated: true, completion: completion)
    }
    
    init(image: UIImage, imageName: String) {
        self.image = image
        self.imageName = imageName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
