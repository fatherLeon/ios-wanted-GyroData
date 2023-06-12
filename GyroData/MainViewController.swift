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
        self.navigationItem.title = "목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "측정", style: .plain, target: self, action: nil)
    }
    
    private func configureView() {
        self.view.backgroundColor = .systemBackground
    }
}

