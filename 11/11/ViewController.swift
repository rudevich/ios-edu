//
//  ViewController.swift
//  11
//
//  Created by 18495524 on 5/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var sharingText: UITextView = {
        let ret = UITextView(frame: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: 300, height: 100)))
        ret.isEditable = true
        ret.center = view.center;
        ret.center.y = CGFloat(ret.center.y - 60)
        ret.backgroundColor = .darkGray
        ret.textColor = .lightGray
        ret.font = UIFont(name: "Arial", size: 20)
        ret.text = "paste some text here"
        ret.autocorrectionType = .no
        return ret
    }()
    
    lazy var sharingButton: UIButton = {
        let ret = UIButton(frame: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: 120, height: 40)))
        ret.center = view.center;
        ret.center.y = CGFloat(ret.center.y + 60)
        ret.backgroundColor = .orange
        ret.setTitle("Share", for: .normal)
        ret.addTarget(self, action: #selector(share), for: .touchUpInside)
        return ret
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        view.addSubview(sharingText)
        view.addSubview(sharingButton)
    }
    
    @objc func share() {
        let items = [sharingText.text, UIImage(named: "img")] as [Any]
        let ac = UIActivityViewController(
            activityItems: items as [Any],
            applicationActivities: [BlablaActivity()]
        )
        ac.excludedActivityTypes = [.postToVimeo, .postToFlickr, .saveToCameraRoll]
        self.present(ac, animated: true, completion: nil)
        ac.completionWithItemsHandler = { (type: UIActivity.ActivityType?, completed: Bool, objs: [Any]?, err: Error?) in
            self.alert("""
                isDone: \(completed==nil ? "cancelled" : "completed")
                activity: \(type?.rawValue)
                changedByActivityCount: \(objs?.count)
            """)
            
        }
    }

    func alert(_ msg: String) {
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        alert.addAction(.init(title: "okay", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }

}

