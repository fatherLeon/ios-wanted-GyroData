//
//  MeasurementViewModel.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/13.
//

import Combine
import Foundation
import CoreMotion

final class MeasurementViewModel {
    private let gyroManager = GyroManager()
    
    @Published var gyroData: (x: Double, y: Double, z: Double) = (0.0, 0.0, 0.0)
    var gyroDatas: [(Double, Double, Double)] = []
    var cancellables: [AnyCancellable] = []
    
    init() {
//        gyroManager.startAccelerometers()
    }
    
    func startMeasurementData(by type: GyroType) {
        switch type {
        case .Gyro:
            gyroManager.startGyro()
        case .Accelerometer:
            gyroManager.startAccelerometers()
        }
    }
    
    func stopMeasurementData(by type: GyroType) {
        switch type {
        case .Gyro:
            gyroManager.stopGyro()
        case .Accelerometer:
            gyroManager.stopAccelerometers()
        }
    }
    
    private func bindingGyroManager() {
        gyroManager.$data
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.gyroDatas.append(data)
                self?.gyroData = data
            }
            .store(in: &cancellables)
    }
}
