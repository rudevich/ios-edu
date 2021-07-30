//
//  DrawViewControllerColorsTable.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

// MARK: - TableView
extension DrawViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedColor = dataSource.colors.remove(at: indexPath.row)
        dataSource.colors.insert(selectedColor, at: 0)
        tableView.reloadData()
        tableView.isHidden = true
        colorButton.backgroundColor = selectedColor
        colorButton.isHidden = false
        colorsTableBackground.isHidden = true
        colorButtonBackground.isHidden = false
        tableView.isHidden = true
        
        canvas.setColor(selectedColor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "drawCell", for: indexPath) as? ColorsTableDrawCell else { return UITableViewCell()}
        cell.configure(model: dataSource.colors[indexPath.row])
        return cell
    }
    
    @objc func selectColor() {
        colorsTable.contentOffset = CGPoint(x: 0, y: 0)
        colorsTable.isHidden = false
        colorButton.isHidden = true
        colorsTableBackground.isHidden = false
        colorButtonBackground.isHidden = true
    }
}
