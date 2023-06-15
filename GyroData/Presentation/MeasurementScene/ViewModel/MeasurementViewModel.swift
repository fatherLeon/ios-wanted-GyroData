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
    private let coredataManager = CoreDataManager()
    private var gyroDatas: [(x: Double, y: Double, z: Double)] = []
    var cancelables: [AnyCancellable] = []
    
    @Published var gyroData: (x: Double, y: Double, z: Double) = (0.0, 0.0, 0.0)
    @Published var isMeasurement: Bool = false
    @Published var isChangedGyroType: Bool = true
    
    init() {
        bindingGyroManager()
    }
    
    func startMeasurementData(by type: Gyro.GyroType) {
        switch type {
        case .Gyro:
            gyroManager.startGyro()
        case .Accelerometer:
            gyroManager.startAccelerometers()
        }
        
        isMeasurement = true
    }
    
    func stopMeasurementData(by type: Gyro.GyroType) {
        switch type {
        case .Gyro:
            gyroManager.stopGyro()
        case .Accelerometer:
            gyroManager.stopAccelerometers()
        }
        
        isMeasurement = false
    }
    
    func saveMeasurementData(by type: Gyro.GyroType) {
        var gyro = Gyro(date: Date(), type: type)
        
        gyroDatas.forEach { gyroData in
            gyro.xValue.append(gyroData.x)
            gyro.yValue.append(gyroData.y)
            gyro.yValue.append(gyroData.z)
        }

        guard let fileURL = LocalFileURLs.receiveURL(by: gyro.id.uuidString) else { return }
        
        do {
            let data = try JSONEncoder().encode(gyro)
            try data.write(to: fileURL)
            coredataManager.create(id: gyro.id, url: fileURL)
        } catch {
            return
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
