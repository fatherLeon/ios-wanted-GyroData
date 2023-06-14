//
//  GyroManager.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/13.
//

import Foundation
import CoreMotion

final class GyroManager {
    @Published var data: (x: Double, y: Double, z: Double) = (0.0, 0.0, 0.0)
    @Published var isMeasurement: Bool = false
    
    private var timer: Timer?
    private var timeoutTimer: Timer?
    private let motionManager = CMMotionManager()
    private let interval = 1.0 / 60.0 * 10.0
    private let timeout = 60.0
    
    func startAccelerometers() {
        motionManager.accelerometerUpdateInterval = interval
        motionManager.startAccelerometerUpdates()
        isMeasurement = true
        
        let timeoutTimer = Timer(timeInterval: timeout, repeats: false) { [weak self] _ in
            self?.stopAccelerometers()
        }
        let timer = Timer(fire: Date(), interval: interval, repeats: true, block: { [weak self] _ in
            guard let data = self?.motionManager.accelerometerData?.acceleration else { return }
            self?.data = (data.x, data.y, data.z)
        })
        
        self.timer = timer
        self.timeoutTimer = timeoutTimer
        RunLoop.current.add(timer, forMode: .default)
        RunLoop.current.add(timeoutTimer, forMode: .default)
    }
    
    func stopAccelerometers() {
        motionManager.stopAccelerometerUpdates()
        isMeasurement = false
        
        timer?.invalidate()
        timeoutTimer?.invalidate()
        timer = nil
        timeoutTimer = nil
    }
    
    func startGyro() {
        motionManager.gyroUpdateInterval = interval
        motionManager.startGyroUpdates()
        isMeasurement = true
        
        let timeoutTimer = Timer(timeInterval: timeout, repeats: false) { [weak self] _ in
            self?.stopGyro()
        }
        let timer = Timer(fire: Date(), interval: interval, repeats: true) { [weak self] _ in
            guard let data = self?.motionManager.gyroData?.rotationRate else { return }
            self?.data = (data.x, data.y, data.z)
        }
        
        self.timer = timer
        self.timeoutTimer = timeoutTimer
        RunLoop.current.add(timer, forMode: .default)
        RunLoop.current.add(timeoutTimer, forMode: .default)
    }
    
    func stopGyro() {
        motionManager.stopGyroUpdates()
        isMeasurement = false
        
        timer?.invalidate()
        timeoutTimer?.invalidate()
        timer = nil
        timeoutTimer = nil
    }
}
