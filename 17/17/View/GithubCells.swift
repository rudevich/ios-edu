//
//  RepoCell.swift
//  17
//
//  Created by 18495524 on 6/5/21.
//

import UIKit
class GithubOrgsCell: UITableViewCell {
    static var id = "github-orgs-cellId"
    
    func setup(with model: GithubOrgsDataResponse) {
        textLabel?.text = model.login
    }
}

class GithubReposCell: UITableViewCell {
    static var id = "repos-orgs-cellId"
    
    func setup(with model: GithubReposDataResponse) {
        textLabel?.text = model.name
    }
}
