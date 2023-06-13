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
        gyroManager.startAccelerometers()
    }
}
