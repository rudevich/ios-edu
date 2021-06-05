//
//  Responses.swift
//  17
//
//  Created by 18495524 on 6/5/21.
//

import Foundation

class GithubOrgsDataResponse: Decodable {
    let login: String
//    let id: Int
//    let nodeId: String
//    let url: String
//    let reposUrl: String
//    let eventsUrl: String
//    let hooksUrl: String
//    let issuesUrl: String
//    let membersUrl: String
//    let publicMembersUrl: String
//    let avatarUrl: String
//    let description: String?
}

class GithubReposDataResponse: Decodable {
    let name: String
}
