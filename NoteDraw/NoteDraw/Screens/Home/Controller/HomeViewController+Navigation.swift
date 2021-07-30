//
//  HomeViewController+Navigation.swift
//  NoteDraw
//
//  Created by 18495524 on 7/30/21.
//

import UIKit

// MARK: - manage navigation

extension HomeViewController {
    func setupNavigation() {
        navigationItem.title = "Images"
        
        showLeftNavigationItems()
        showRightNavigationItems()
    }
    
    func showLeftNavigationItems() {
        let buttonDeleteAll = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(buttonDeleteAllTapped))
        
        let buttonDownload = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(buttonDownloadTapped))
        
        var leftNavigationIems = [buttonDeleteAll]
        let ud = UserDefaults.standard.object(forKey: "done") as? Int
        if (404 != ud) {
            leftNavigationIems.append(buttonDownload)
        }
        navigationItem.leftBarButtonItems = leftNavigationIems.reversed()
    }
    
    func showRightNavigationItems() {
        let buttonDraw = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonDrawTapped))

        navigationItem.rightBarButtonItems = [buttonDraw].reversed()
    }
    
    @objc func buttonDrawTapped() {
        showDrawScreenForImage()
    }
    
    @objc func buttonDeleteAllTapped() {
        UserDefaults.standard.removeObject(forKey: "done")
        showLeftNavigationItems()
        frc.deleteAllImages() { [unowned self] in
            UIView.transition(
                with: imagesCollection,
                duration: 0.35,
                options: .transitionCrossDissolve,
                animations: {
                    self.imagesCollection.reloadData()
                }
            )
        }
    }
    
    @objc func buttonDownloadTapped() {
        downloadImagesList()
        UserDefaults.standard.set(404, forKey: "done")
        showLeftNavigationItems()
    }
}
