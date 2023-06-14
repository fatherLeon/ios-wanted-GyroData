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
    @Published var isMeasurement: Bool = false
    var gyroDatas: [(x: Double, y: Double, z: Double)] = []
    var cancelables: [AnyCancellable] = []
    
    init() {
        bindingGyroManager()
    }
    
    func startMeasurementData(by type: GyroType) {
        switch type {
        case .Gyro:
            gyroManager.startGyro()
        case .Accelerometer:
            gyroManager.startAccelerometers()
        }
        
        isMeasurement = true
    }
    
    func stopMeasurementData(by type: GyroType) {
        switch type {
        case .Gyro:
            gyroManager.stopGyro()
        case .Accelerometer:
            gyroManager.stopAccelerometers()
        }
        
        isMeasurement = false
    }
    
    private func bindingGyroManager() {
        gyroManager.$data
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.gyroDatas.append(data)
                self?.gyroData = data
            }
            .store(in: &cancelables)
        
        gyroManager.$isMeasurement
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.isMeasurement = data
            }
            .store(in: &cancelables)
    }
}
