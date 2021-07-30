//
//  NetworkServiceProtocol.swift
//  NoteDraw
//
//  Created by 18495524 on 7/30/21.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<CustomJSONStruct:Decodable>(
        address: String,
        params: NetworkServiceURLParams,
        callback: @escaping (Result<[CustomJSONStruct], NetworkServiceError>)->Void
    )
}
