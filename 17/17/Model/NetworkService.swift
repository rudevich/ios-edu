//
//  Grabber.swift
//  17
//
//  Created by 18495524 on 6/4/21.
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
    
    func fetch<CustomJSONStruct:Decodable>(
        address: String,
        params: NetworkServiceURLParams,
        callback: @escaping (
            Result<[CustomJSONStruct], NetworkServiceError>,
            String?
        )->Void
    ) {
        var components = URLComponents(string: address)
        var queryItems:[URLQueryItem] = []
        for (key, value) in params {
            queryItems.append(.init(name: key, value: value))
        }
        components?.queryItems = queryItems

        guard let url = components?.url else {
            callback(.failure(.unknown), nil)
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
                callback(.failure(.network), nil)
                return
            }
            do {
                let linkHeaderString = httpResponse.value(forHTTPHeaderField: "Link")
                let linkHeaderSplitted = linkHeaderString?.split(separator: " ")
                var nextPageLink:String? = linkHeaderSplitted?.first?.replacingOccurrences(
                    of: "[<>;]", with: "",
                    options: .regularExpression,
                    range: nil
                )
//                print(" ----a- ",address)
//                print(" ---- ",nextPageLink ?? "nil")
                
                if (nextPageLink == address) {
                    nextPageLink = nil
                }
                let responseData = try self.decoder.decode([CustomJSONStruct].self, from: data!)
                callback(.success(responseData), nextPageLink)
            } catch {
                callback(.failure(.decoding), nil)
            }
        }.resume()
    }
    
}

