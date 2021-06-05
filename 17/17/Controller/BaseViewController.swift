//
//  RootViewController.swift
//  17
//
//  Created by 18495524 on 6/5/21.
//

import UIKit

class BaseViewController: UIViewController {
    private let spinner = SpinnerViewController()
    
    var isLoading = false {
        didSet {
            guard oldValue != isLoading else { return }
            showSpinner(isLoading)
        }
    }
    
    var isThereMore = true
    
    private func showSpinner(_ loading: Bool) {
        if (loading) {
            self.addChild(spinner)
            spinner.view.frame = self.view.frame
            view.addSubview(spinner.view)
            spinner.didMove(toParent: self)
        } else {
            spinner.willMove(toParent: nil)
            spinner.view.removeFromSuperview()
            spinner.removeFromParent()
        }
    }
    
    func setLoading(_ loading: Bool) {
        showSpinner(loading)
    }
    
    func processTableData<CustomJSONStruct>(_ data: [CustomJSONStruct], into destination: inout [CustomJSONStruct]) {
        for cellData in data {
            destination.append(cellData)
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
