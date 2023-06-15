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
    private var gyroDatas: [(x: Double, y: Double, z: Double)] = []
    var cancelables: [AnyCancellable] = []
    
    @Published var gyroData: (x: Double, y: Double, z: Double) = (0.0, 0.0, 0.0)
    @Published var isMeasurement: Bool = false
    @Published var isChangedGyroType: Bool = true
    
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
    
    func saveMeasurementData(by type: GyroType) {
        var gyro = Gyro(date: Date(), type: type)
        
        gyro.value = gyroDatas
        
        let xValue = gyro.value.map { $0.x }
        let yValue = gyro.value.map { $0.y }
        let zValue = gyro.value.map { $0.z }
        
        let jsonGyro = JsonGyroModel(id: gyro.id,
                                     date: gyro.date,
                                     type: type.text,
                                     xValue: xValue,
                                     yValue: yValue,
                                     zValue: zValue)
        
        do {
            let data = JSONEncoder().encode(jsonGyro)
        } catch {
            
        }
        
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
        
        gyroManager.$isChangedGyroType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isChangedGyroType in
                self?.isChangedGyroType = isChangedGyroType
            }
            .store(in: &cancelables)
    }
}
