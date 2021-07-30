//
//  ImagePreviewController.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

final class ImagePreviewController: UIViewController {
    private let image: UIImage
    private let imageName: String
    
    var editCompletion: (() -> Void)?
    var removeCompletion: (() -> Void)?
    var renameCompletion: (() -> Void)?
    var shareCompletion: (() -> Void)?
    
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
        button.setBackgroundImage(UIImage(systemName: "hand.draw"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var renameImageButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(systemName: "textbox"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(renameButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var shareImageButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var removeImageButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
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
        view.addSubview(renameImageButton)
        view.addSubview(removeImageButton)
        view.addSubview(shareImageButton)
        view.addSubview(label)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            editImageButton.widthAnchor.constraint(equalToConstant: 40),
            editImageButton.heightAnchor.constraint(equalTo: editImageButton.widthAnchor),
            editImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            editImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            renameImageButton.widthAnchor.constraint(equalToConstant: 40),
            renameImageButton.heightAnchor.constraint(equalTo: editImageButton.widthAnchor),
            renameImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            renameImageButton.trailingAnchor.constraint(equalTo: editImageButton.leadingAnchor, constant: -30),
            
            shareImageButton.widthAnchor.constraint(equalToConstant: 40),
            shareImageButton.heightAnchor.constraint(equalTo: editImageButton.widthAnchor),
            shareImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            shareImageButton.trailingAnchor.constraint(equalTo: renameImageButton.leadingAnchor, constant: -30),
            
            removeImageButton.widthAnchor.constraint(equalToConstant: 40),
            removeImageButton.heightAnchor.constraint(equalTo: editImageButton.widthAnchor),
            removeImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            removeImageButton.trailingAnchor.constraint(equalTo: shareImageButton.leadingAnchor, constant: -30),

            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func editButtonTapped() {
        dismiss(animated: true, completion: editCompletion)
    }
    
    @objc private func renameButtonTapped() {
        dismiss(animated: true, completion: renameCompletion)
    }
    
    @objc private func removeButtonTapped() {
        dismiss(animated: true, completion: removeCompletion)
    }
    
    @objc private func shareButtonTapped() {
        dismiss(animated: true, completion: shareCompletion)
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
