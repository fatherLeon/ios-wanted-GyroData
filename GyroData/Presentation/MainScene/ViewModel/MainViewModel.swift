//
//  MainViewModel.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

import Combine
import Foundation

class MainViewModel {
    var gyros = CurrentValueSubject<[Gyro], Never>([])
    var cancellables: [AnyCancellable] = []
    
    init() {
        let data = [Gyro(date: Date(), type: .Accelerometer, value: 43.4),
                    Gyro(date: Date(), type: .Gyro, value: 60.0),
                    Gyro(date: Date(), type: .Accelerometer, value: 30.4)]
        
        gyros.send(data)
    }
    
    func deleteGyro(_ gyro: Gyro) {
    }
}
