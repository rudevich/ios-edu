//
//  NetworkServiceProtocol.swift
//  17
//
//  Created by 18495524 on 6/5/21.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<CustomJSONStruct:Decodable>(
        address: String,
        params: NetworkServiceURLParams,
        callback: @escaping (Result<[CustomJSONStruct], NetworkServiceError>, String?)->Void
    )
}
