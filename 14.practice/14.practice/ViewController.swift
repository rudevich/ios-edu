//
//  ViewController.swift
//  14.practice
//
//  Created by 18495524 on 5/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    var cities = ["Link", """
    let ret = UIViewController()
    let button = UIButton()
    button.backgroundColor = .darkGray
    button.center = ret.view.center
    button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
    ret.view = button
    return ret
    """, "Ganondorf", "Midna", "Moscow", "Saint-Petersburg", "Montana", "Iowa", "Jamaica", "Sacramento", "Ankara", "Istanbul", "Kyiv", "Minneapolis"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.allowsSelection = true// true
        
        tableView.backgroundColor = .lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    lazy var supportViewController: UIViewController = {
        let ret = UIViewController()
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.center = ret.view.center
        button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        ret.view = button
        return ret
    }()
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = TableViewCell.heightFor(for: cities[indexPath.row], width: tableView.frame.width - tableView.frame.width * 100 / 20)
        if (height < 50) {
            height = 84
        }
        return height
        //        return CGFloat(Int.random(in: 50...90))
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.textLabel?.text = cities[indexPath.row]
        cell.backgroundColor = .clear
        cell.delegate = self
        cell.index = indexPath.row
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        cell.textLabel?.baselineAdjustment = .none
        cell.textLabel?.preferredMaxLayoutWidth = 100
//        cell.textLabel?.font = UIFont.
        
        return cell
    }
    
    

}

protocol CellDelegate {
    func didTapOnButton(index: Int) -> Void
}

extension ViewController: CellDelegate {
    func didTapOnButton(index: Int) {
        let v = supportViewController.view as! UIButton
        v.setTitle(cities[index], for: .normal)
        present(supportViewController, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(cities[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("append")
    }
}


