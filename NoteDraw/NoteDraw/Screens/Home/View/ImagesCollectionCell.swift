//
//  ImagesCollectionView.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

final class ImagesCollectionCell: UICollectionViewCell {
    static let cellId = "image-cell"
    
    var date: Date?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Arial", size: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override func updateConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(labelConstraints)

        super.updateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

