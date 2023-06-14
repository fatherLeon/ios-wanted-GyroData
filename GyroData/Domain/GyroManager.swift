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
    
    private var timer: Timer?
    private let motionManager = CMMotionManager()
    private let interval = 1.0 / 60.0 * 10.0
    
    func startAccelerometers() {
        motionManager.accelerometerUpdateInterval = interval
        motionManager.startAccelerometerUpdates()
        
        let timer = Timer(fire: .now, interval: interval, repeats: true, block: { [weak self] _ in
            guard let data = self?.motionManager.accelerometerData?.acceleration else { return }
            self?.data = (data.x, data.y, data.z)
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
        
        let timer = Timer(fire: .now, interval: interval, repeats: true) { [weak self] _ in
            guard let data = self?.motionManager.gyroData?.rotationRate else { return }
            self?.data = (data.x, data.y, data.z)
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
