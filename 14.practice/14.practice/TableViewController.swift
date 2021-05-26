//
//  TableViewController.swift
//  14.practice
//
//  Created by 18495524 on 5/25/21.
//

import UIKit

class TableViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = TableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "wow"
        return cell
    }
}
