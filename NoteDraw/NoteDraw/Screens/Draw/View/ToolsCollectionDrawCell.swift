//
//  CollectionViewDrawCell.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

final class ToolsCollectionDrawCell: UICollectionViewCell {
    
    static let cellId = "tool-id"
    
    let dim = CGFloat(45.0)
    
    lazy var imageCell: UIImageView = {
        let image = UIImageView(image: UIImage())
        image.tintColor = .black
        return image
    }()
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: dim, height: dim))
        view.layer.borderColor = UIColor(named: "black")?.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        return view
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        imageCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.widthAnchor.constraint(equalToConstant: dim),
            backView.heightAnchor.constraint(equalToConstant: dim),
            backView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageCell.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            imageCell.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        ])
        super.updateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backView)
        backView.addSubview(imageCell)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = backView.frame.width / 2
    }
    
    func configure(model: UIImage) {
        imageCell.image = model
    }
}

