//
//  APIUrls.swift
//  17
//
//  Created by 18495524 on 6/5/21.
//

import Foundation
final class GithubAPIs {
    static func orgs() -> String {
        return "https://api.github.com/organizations"
    }
    static func repos(of orgName: String) -> String {
        return "https://api.github.com/orgs/\(orgName)/repos"
    }
}
