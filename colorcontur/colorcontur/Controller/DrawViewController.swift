//
//  DrawViewController.swift
//  colorcontur
//
//  Created by 18495524 on 7/9/21.
//

import UIKit

class DrawViewController: UIViewController {
    
    var delegate: LocalListViewController?
    
    lazy var canvas: CanvasView = {
        let canvas = CanvasView(frame: self.view.frame)
        canvas.router = Router.route
        canvas.translatesAutoresizingMaskIntoConstraints = false
        return canvas
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Draw contours"
        
        addButtonsToNavigation()
        
        view.backgroundColor = .white
        view.addSubview(canvas)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        canvas.clear()
    }
    
    private func updateConstraints() {
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }

    private func addButtonsToNavigation() {
        let undo = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(canvasUndo))
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(canvasSave))
        
        undo.isEnabled = false
        save.isEnabled = false
        
        canvas.completion = {
            undo.isEnabled = $0
            save.isEnabled = $0
        }
        
        navigationItem.rightBarButtonItems = [undo, save].reversed()
    }
    
    @objc private func canvasUndo() {
        canvas.undo()
    }
    
    @objc private func canvasSave() {
        canvas.save()
        Router.route?.replace("coloring", animated: true)
    }

}

