//
//  MainViewController.swift
//  GyroData
//
//  Created by kjs on 2022/09/16.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
    }
}

// MARK: UI
extension MainViewController {
    private func configureNavigationBar() {
        navigationItem.title = "목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "측정", style: .plain, target: self, action: nil)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

