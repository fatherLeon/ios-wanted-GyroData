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
    @Published var isChangedGyroType: Bool = true
    
    private var timer: Timer?
    private var timeoutTimer: Timer?
    private let motionManager = CMMotionManager()
    private let interval = 1.0 / 10.0
    private var timeout = 0
    
    func startAccelerometers() {
        motionManager.accelerometerUpdateInterval = interval
        motionManager.startAccelerometerUpdates()
        isMeasurement = true
        isChangedGyroType = false
        
        let timeoutTimer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeout += 1
            if self.timeout > 60 {
                self.stopAccelerometers()
                self.resetTimeout()
            }
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
        isChangedGyroType = false
        
        let timeoutTimer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeout += 1
            if self.timeout > 60 {
                self.stopGyro()
                self.resetTimeout()
            }
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
    
    private func resetTimeout() {
        isChangedGyroType = true
        timeout = 0
    }
}
