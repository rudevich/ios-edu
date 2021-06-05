//
//  ViewController.swift
//  17
//
//  Created by 18495524 on 6/4/21.
//

import UIKit

class ViewController: BaseViewController {
    var detailsViewController: DetailsViewController?
    var networkService: NetworkService
    var dataSource = [GithubOrgsDataResponse]()
    var selectedCompany: String?
    var nextPageLink: String?
    
    init(_ networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var table:UITableView = {
        let table = UITableView(frame: view.frame)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    
        setupGithubOrgsTable()
        loadGithubOrgsData()
        setupNavBar()
    }
    
    func setupGithubOrgsTable() {
        view.addSubview(table)
        table.register(GithubOrgsCell.self, forCellReuseIdentifier: GithubOrgsCell.id)
    }
    
    func setupNavBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [refreshButton]
        navigationItem.title = "Orgs on Github"
    }
    
    @objc func refreshTapped() {
        dataSource = []
        nextPageLink = nil
        isThereMore = true
        loadGithubOrgsData()
    }
    
    func loadGithubOrgsData() {
        setLoading(true)
        var queryParams = [String:String]()
        if nextPageLink == nil {
            queryParams = [
                "per_page": "20"
            ]
        }
        networkService.fetch(
            address: self.nextPageLink ?? GithubAPIs.orgs(),
            params: queryParams,
            callback: { [unowned self] (response: Result<[GithubOrgsDataResponse], NetworkServiceError>, nextPageLink: String? ) in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let data):
                        processTableData(data, into: &dataSource)
                        self.nextPageLink = nextPageLink
                        self.table.reloadData()
                        if (self.nextPageLink == nil) {
                            isThereMore = false
                        }
                    case .failure(let error):
                        showAlert(msg: message(for: error))
                    }
                    self.setLoading(false)
                }
            }
        )
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: GithubOrgsCell.id, for: indexPath) as! GithubOrgsCell
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!isLoading && isThereMore && indexPath.row == self.dataSource.count - 1) {
            loadGithubOrgsData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.detailsViewController != nil else { return }
        detailsViewController?.forCompany = dataSource[indexPath.row].login
        navigationController?.pushViewController(self.detailsViewController!, animated: true)
    }
}
