//
//  MainViewController.swift
//  GyroData
//
//  Created by kjs on 2022/09/16.
//

import UIKit

class MainViewController: UIViewController {
    private enum Section {
        case main
    }
    
    private var datasource: UITableViewDiffableDataSource<Section, Gyro>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Gyro>()
    private let viewModel = MainViewModel()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarUI()
        configureViewUI()
        configureTableViewUI()
        configureTableView()
        configureTableViewDatasource()
        configureSnapshot()
        
        binding()
    }
    
    private func binding() {
        viewModel.$gyros
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gyros in
                guard let self = self else { return }
                self.applySnapshot(by: gyros)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func applySnapshot(by items: [Gyro]) {
        snapshot.deleteSections([.main])
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        datasource?.apply(snapshot)
    }
    
    @objc private func pushMeasurementViewController() {
    }
    
    @objc private func pushPlayGraphViewController() {
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let gyro = viewModel.gyros[indexPath.row]
        let playingAction = UIContextualAction(style: .normal, title: "Play") { [weak self]  action, view, completion in
            self?.pushPlayGraphViewController()
            completion(true)
        }
        playingAction.backgroundColor = .systemGreen
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            self?.viewModel.deleteGyro(gyro)
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction, playingAction])
    }
}

// MARK: Datasource && Snapshot
extension MainViewController {
    private func configureTableViewDatasource() {
        datasource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GyroCell.identifier) as? GyroCell else { return UITableViewCell() }
            
            cell.apply(by: itemIdentifier.date,
                       type: itemIdentifier.type.text,
                       data: itemIdentifier.value)
            
            return cell
        })
        
        tableView.dataSource = datasource
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.register(GyroCell.self, forCellReuseIdentifier: GyroCell.identifier)
    }
    
    private func configureSnapshot() {
        snapshot.appendSections([.main])
    }
}

// MARK: UI
extension MainViewController {
    private func configureNavigationBarUI() {
        navigationItem.title = "목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "측정", style: .plain, target: self, action: #selector(pushMeasurementViewController))
    }
    
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableViewUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.separatorStyle = .none
    }
}

