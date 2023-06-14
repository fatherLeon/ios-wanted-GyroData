//
//  MeasurementViewModel.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/13.
//

import Foundation

final class MeasurementViewModel {
    private let gyroManager = GyroManager()
    
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
}
