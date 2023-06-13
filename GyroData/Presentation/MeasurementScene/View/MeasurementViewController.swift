//
//  MeasurementViewController.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/13.
//

import UIKit

final class MeasurementViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Acc", "Gyro"])
        
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewUI()
        configureNavigationBarUI()
    }

}

// MARK: UI
extension MeasurementViewController {
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
        
        let mainStackView = UIStackView(arrangedSubviews: [segmentedControl])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavigationBarUI() {
        navigationItem.title = "측정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장",
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        navigationItem.backButtonTitle = ""
    }
}
