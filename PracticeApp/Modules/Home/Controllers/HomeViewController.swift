//
//  ViewController.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 25/07/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let tableView = UITableView()
    private let tableTitle = UILabel()
    private let loadingLabel = UILabel()
    private let cellIdentifier = "TableCell"
    private var homeViewModel = HomeViewModel()
    private var profileViewModel = ProfileViewModel()
    private var userData : [Users]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupLoaderView()
        self.homeViewModel.bindUsersViewModelToController = { data in
            self.userData = data
            self.reloadTableDataAndStopLoader()
        }
    }
    
    private func setupViews() {
        self.title = "Pull Requests"
        self.view.backgroundColor = .white
        self.setupTableView()
        
    }
    
    private func reloadTableDataAndStopLoader() {
        self.tableView.reloadData()
        self.loadingLabel.isHidden = true
        self.view.stopLoading()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupLoaderView() {
        loadingLabel.text = "Please Wait..."
        self.view.addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        loadingLabel.isHidden = false
        self.view.showLoading()
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.userData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell, let cellData = self.userData else {
            return UITableViewCell()
        }
        cell.setLabelAndImage(data: cellData, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let name = self.userData?[indexPath.row].user?.login {
            let profileVc = ProfileViewController(userName: name)
            let userType = self.userData?[indexPath.row].user?.type
            if userType != "Organization" {
                profileVc.isBorderd = true
            }
            navigationController?.pushViewController(profileVc, animated: true)
        }
    }
    
}
