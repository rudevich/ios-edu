//
//  HomeViewController+Network.swift
//  NoteDraw
//
//  Created by 18495524 on 7/30/21.
//

import UIKit

// MARK: - network requests

extension HomeViewController {
    func downloadImagesList() {
        setLoading(true)
        networkService.fetch(
            address: "https://rudevich.github.io/images.json",
            params: [:],
            callback: { [unowned self] (response: Result<[ImagesListNetworkResponse], NetworkServiceError>) in
                switch response {
                case .success(let data):
                    downloadImagesFromList(data)
                case .failure(let error):
                    DispatchQueue.main.async {
                        showAlert(msg: message(for: error))
                    }
                }
                DispatchQueue.main.async {
                    self.setLoading(false)
                }
            }
        )
    }
    
    func downloadImagesFromList<CustomJSONStruct>(_ data: [CustomJSONStruct]) {
        guard let imagesListResponse = data as? [ImagesListNetworkResponse] else { return }
        for image in imagesListResponse {
            print(image.file)
            let url = URL(string:"https://rudevich.github.io/\(image.file)")!
            networkService.getData(from: url) { [unowned self] data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let title = response?.suggestedFilename
                    let image = UIImage(data: data)
                    frc.insertImage(title: title, image: image)
                }
            }
            print(image.file + "after")
        }
    }
    
    func message(for error: NetworkServiceError) -> String {
        switch error {
        case .network:
            return "Request failed"
        case .decoding:
            return "Error with json decoding"
        case .unknown:
            return "wftrudunmn?"
        }
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        present(alert, animated: true)
    }
}
