//
//  DrawCell.swift
//  Lesson15-16
//
//  Created by Владислав Галкин on 29.05.2021.
//

import UIKit

final class TableViewDrawCell: UITableViewCell {
    
    lazy var colorVIew: UIView = {
        let colorView = UIView(frame: .zero)
        colorView.backgroundColor = .red
        colorView.layer.borderWidth = 1
        colorView.layer.borderColor = UIColor.black.cgColor
        return colorView
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        colorVIew.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorVIew.widthAnchor.constraint(equalToConstant: 30),
            colorVIew.heightAnchor.constraint(equalToConstant: 30),
            colorVIew.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            colorVIew.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            colorVIew.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        super.updateConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(colorVIew)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        colorVIew.layer.cornerRadius = colorVIew.frame.height / 2
    }
    
    func configure(model: UIColor) {
        colorVIew.backgroundColor = model
    }
}
