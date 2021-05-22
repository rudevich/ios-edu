//
//  BlablaActivity.swift
//  11
//
//  Created by 18495524 on 5/22/21.
//

import UIKit

class BlablaActivity: UIActivity {
    var activityItems = [Any]()
    
    lazy var img = {
        return UIImage(named: "img")
    }()
    
    override init() {
        super.init()
    }
    
    
    
    override var activityTitle: String? {
        return "Blabla Share"
    }

    override var activityImage: UIImage? {
        return img
    }
    
    override var activityType: UIActivity.ActivityType {
        return UIActivity.ActivityType(rawValue: "bla.bla.activity")
    }
    
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        self.activityItems = activityItems
    }
    
    override func perform() {
        act(activityItems)
        activityDidFinish(true)
    }
    
    func act(_ Items: [Any]) {
        print("\(Items.count)")
    }

}
