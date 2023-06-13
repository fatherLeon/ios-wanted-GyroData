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
    private let startMeasurementButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("측정", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        
        return button
    }()
    private let stopMeasurementButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("정지", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        
        return button
    }()
    
    private let viewModel = MeasurementViewModel()

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
        
        let mainStackView = UIStackView(arrangedSubviews: [segmentedControl,
                                                          startMeasurementButton,
                                                          stopMeasurementButton])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        
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
