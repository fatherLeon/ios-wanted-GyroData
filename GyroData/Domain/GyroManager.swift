//
//  GyroManager.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/13.
//

import Foundation
import CoreMotion

final class GyroManager {
    private var timer: Timer?
    private let motionManager = CMMotionManager()
    private let interval = 1.0 / 60.0 * 10.0
    
    func startAccelerometers() {
        motionManager.accelerometerUpdateInterval = interval
        motionManager.startAccelerometerUpdates()
        
        let timer = Timer(fire: Date(), interval: interval, repeats: true, block: { [weak self] _ in
            let data = self?.motionManager.accelerometerData
            print(data)
        })
        
        self.timer = timer
        RunLoop.current.add(timer, forMode: .default)
    }
    
    func stopAccelerometers() {
        motionManager.stopAccelerometerUpdates()
        
        timer?.invalidate()
        timer = nil
    }
    
    func startGyro() {
        motionManager.gyroUpdateInterval = interval
        motionManager.startGyroUpdates()
        
        let timer = Timer(fire: Date(), interval: interval, repeats: true) { [weak self] _ in
            let data = self?.motionManager.gyroData
            print(data)
        }
        
        self.timer = timer
        RunLoop.current.add(timer, forMode: .default)
    }
    
    func stopGyro() {
        motionManager.stopGyroUpdates()
        
        timer?.invalidate()
        timer = nil
    }
}
