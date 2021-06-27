//
//  NetworkService.swift
//  Puzzles
//
//  Created by Leonid Serebryanyy on 18.11.2019.
//  Copyright © 2019 Leonid Serebryanyy. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: String, Error {
    case unknownURL = "Unknown url"
    case unknownError = "Unknown network error"
    case unknownData = "Unknown data"
    case unknownGroupError = "Some of the urls are wrong"
}

class NetworkService {
	
	let session: URLSession
	
	private var queue = DispatchQueue(label: "com.sber.puzzless", qos: .default, attributes: .concurrent)

	
	init() {
		session = URLSession(configuration: .default)
	}
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession
            .shared
            .dataTask(with: url, completionHandler: completion)
            .resume()
    }
	
	
	// MARK:- Первое задание
	
	///  Вот здесь должны загружаться 4 картинки и совмещаться в одну.
	///  Для выполнения этой задачи вам можно изменять только этот метод.
	///  Метод, соединяющий картинки в одну, уже написан (вызывается в конце).
	///  Ответ передайте в completion.
	///  Помните, что надо сделать так, чтобы метод работал как можно быстрее.
	public func loadPuzzle(completion: @escaping (Result<UIImage, Error>) -> ()) {
		// это адреса картинок. они работающие, всё ок!
		let firstURL = URL(string:  "https://storage.googleapis.com/ios_school/tu.png")!
		let secondURL = URL(string: "https://storage.googleapis.com/ios_school/pik.png")!
		let thirdURL = URL(string:  "https://storage.googleapis.com/ios_school/cm.jpg")!
		let fourthURL = URL(string: "https://storage.googleapis.com/ios_school/apple.jpeg")!
		let urls = [firstURL, secondURL, thirdURL, fourthURL]
		
        var results = [UIImage?]()
        let group = DispatchGroup()
        
        urls.forEach { url in
            group.enter()
            DispatchQueue(label: "air-puzzle-\(url.absoluteString)", qos: .userInitiated, attributes: .concurrent).async { [unowned self] in
                getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(url)
                    results.append(UIImage(data: data))
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            let results = results.compactMap { $0 }
            guard results.count == urls.count else {
                completion(.failure(NetworkError.unknownGroupError))
                return
            }
            if let merged = ImagesServices.image(byCombining: results) {
                completion(.success(merged))
            }
        }
        
	}
	
	
	// MARK:- Второе задани
	
	
	///  Здесь задание такое:
	///  У вас есть keyURL, который приведёт вас к ссылке на клад.
	///  Верните картинку с этим кладом в completion
	public func loadQuiz(completion: @escaping(Result<UIImage, Error>) -> ()) {
		let keyURL = URL(string: "https://sberschool-c264c.firebaseio.com/enigma.json?avvrdd_token=AIzaSyDqbtGbRFETl2NjHgdxeOGj6UyS3bDiO-Y")
		
        DispatchQueue(label: "air-quiz-q", qos: .userInitiated, attributes: .concurrent).async { [unowned self] in
            if let url = keyURL {
                let contents = try? String(contentsOf: url)
                
                if let kladURL = contents?.filter({ $0 != "\"" }),
                   let url = URL(string: kladURL) {
                    getData(from: url) { data, response, error in
                        guard let data = data, error == nil else {
                            completion(.failure(NetworkError.unknownError))
                            return
                        }
                        let image = UIImage(data: data) ?? UIImage()
                        completion(.success(image))
                    }
                } else {
                    completion(.failure(NetworkError.unknownData))
                }
            }
        }
	
	}
	
}
