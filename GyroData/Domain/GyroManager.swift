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
    
    func startAccelerometers() {
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0 * 10
        motionManager.startAccelerometerUpdates()
        
        let timer = Timer(fire: Date(), interval: 1.0 / 60.0, repeats: true, block: { [weak self] _ in
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
}
