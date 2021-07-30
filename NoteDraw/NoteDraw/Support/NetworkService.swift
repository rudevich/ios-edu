//
//  NetworkService.swift
//  NoteDraw
//
//  Created by 18495524 on 7/30/21.
//

import Foundation
import UIKit

typealias NetworkServiceData = Any

typealias NetworkServiceURLParams = [String: String?]

enum NetworkServiceError: Error {
    case network
    case decoding
    case unknown
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        session.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func fetch<CustomJSONStruct:Decodable>(
        address: String,
        params: NetworkServiceURLParams,
        callback: @escaping (
            Result<[CustomJSONStruct], NetworkServiceError>
        )->Void
    ) {
        var components = URLComponents(string: address)
        var queryItems:[URLQueryItem] = []
        for (key, value) in params {
            queryItems.append(.init(name: key, value: value))
        }
        components?.queryItems = queryItems

        guard let url = components?.url else {
            callback(.failure(.unknown))
            return
        }
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadRevalidatingCacheData,
            timeoutInterval: 120
        )
        session.dataTask(with: request) { (data: Data?, resp: URLResponse?, error: Error?) in
            guard
                let httpResponse = resp as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil,
                data != nil
            else {
                callback(.failure(.network))
                return
            }
            do {
                let responseData = try self.decoder.decode([CustomJSONStruct].self, from: data!)
                callback(.success(responseData))
            } catch {
                callback(.failure(.decoding))
            }
        }.resume()
    }
    
}
