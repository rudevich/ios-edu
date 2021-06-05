//
//  ReposViewController.swift
//  17
//
//  Created by 18495524 on 6/5/21.
//

import UIKit

class DetailsViewController: BaseViewController {
    var nextPageLink: String?
    var forCompany: String?
    var networkService: NetworkService
    var dataSource = [GithubReposDataResponse]()
    
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
        setupGithubReposTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetTableData()
        loadGithubReposData()
        setupNavBar()
    }
    
    func resetTableData() {
        dataSource = []
        nextPageLink = nil
        isThereMore = true
        table.reloadData()
    }
    
    func setupGithubReposTable() {
        view.addSubview(table)
        table.register(GithubReposCell.self, forCellReuseIdentifier: GithubReposCell.id)
    }
    
    func setupNavBar() {
        navigationItem.title = "Repos of \(forCompany!) on Github"
    }
    
    func loadGithubReposData() {
        guard forCompany != nil else { return }
        setLoading(true)
        var queryParams = [String:String]()
        if nextPageLink == nil {
            queryParams = [
                "per_page": "20"
            ]
        }
        networkService.fetch(
            address: nextPageLink ?? GithubAPIs.repos(of: forCompany!),
            params: queryParams,
            callback: { [unowned self] (response: Result<[GithubReposDataResponse], NetworkServiceError>, nextPageLink: String?) in
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

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: GithubReposCell.id, for: indexPath) as! GithubReposCell
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!isLoading && isThereMore && indexPath.row == self.dataSource.count - 1) {
            loadGithubReposData()
        }
    }
}

