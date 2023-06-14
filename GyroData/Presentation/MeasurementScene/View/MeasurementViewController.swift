//
//  MeasurementViewController.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/13.
//

import Combine
import UIKit

final class MeasurementViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [GyroType.Accelerometer.text, GyroType.Gyro.text])
        
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        
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
    private let graphView = {
        let view = GraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel = MeasurementViewModel()
    private var cancelables: [AnyCancellable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewUI()
        configureNavigationBarUI()
        configureButton()
        
        binding()
    }
    
    private func binding() {
        viewModel.$gyroData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gyroData in
                self?.graphView.updateView(x: gyroData.x, y: gyroData.y, z: gyroData.z)
            }
            .store(in: &cancelables)
        
        viewModel.$isMeasurement
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isPlaying in
                self?.segmentedControl.isEnabled = !isPlaying
                self?.startMeasurementButton.isEnabled = !isPlaying
                self?.stopMeasurementButton.isEnabled = isPlaying
            }
            .store(in: &cancelables)
    }

    @objc private func didTapMeasurementButton() {
        let type: GyroType = segmentedControl.selectedSegmentIndex == 0 ? .Accelerometer : .Gyro
        
        viewModel.startMeasurementData(by: type)
    }
    
    @objc private func didTapStopMeasurementButton() {
        let type: GyroType = segmentedControl.selectedSegmentIndex == 0 ? .Accelerometer : .Gyro
        
        viewModel.stopMeasurementData(by: type)
    }
}

extension MeasurementViewController {
    private func configureButton() {
        startMeasurementButton.addTarget(self, action: #selector(didTapMeasurementButton), for: .touchUpInside)
        stopMeasurementButton.addTarget(self, action: #selector(didTapStopMeasurementButton), for: .touchUpInside)
    }
}

// MARK: UI
extension MeasurementViewController {
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
        
        let mainStackView = UIStackView(arrangedSubviews: [segmentedControl,
                                                           graphView,
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
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
