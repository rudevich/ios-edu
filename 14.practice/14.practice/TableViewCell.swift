//
//  TableViewCell.swift
//  14.practice
//
//  Created by 18495524 on 5/25/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    var delegate: CellDelegate?
    
    lazy var button: UIButton = {
//        let button = UIButton(frame: CGRect(x: 200, y: 0, width: 60, height: 60))
        let button = UIButton()
        button.setTitle("go", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.addTarget(self, action: #selector(callDidTapOnButton), for: .touchUpInside)
        
        return button
    }()
    
    var index:Int = 0
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: CGFloat(0.2)).isActive = true
    }
    
    @objc func callDidTapOnButton() {
        delegate?.didTapOnButton(index: self.index)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clicked(resp: UIGestureRecognizer) {
        print("sdf", resp)
    }
    
    static var fonter: UIFont = UIFont.systemFont(ofSize: 12)
    
    static func heightFor(for text: String, width: CGFloat) -> CGFloat {
        
        let s = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.font: fonter]
        )
        let rect = s.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        return rect.size.height + 16
    }

}
