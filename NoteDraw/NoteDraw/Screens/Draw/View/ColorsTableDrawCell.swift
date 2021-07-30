//
//  TableViewDrawCell.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

final class ColorsTableDrawCell: UITableViewCell {
    
    lazy var colorView: UIView = {
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
        colorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            colorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        super.updateConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(colorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        colorView.layer.cornerRadius = colorView.frame.height / 2
    }
    
    func configure(model: UIColor) {
        colorView.backgroundColor = model
    }
}
