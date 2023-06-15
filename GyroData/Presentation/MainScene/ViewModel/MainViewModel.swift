//
//  MainViewModel.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

import Combine
import Foundation

final class MainViewModel {
    @Published var gyros: [Gyro] = []
    var cancellables: [AnyCancellable] = []
    
    init() {
        let data = [Gyro(date: Date(), type: .Accelerometer, value: [(1, 2, 1)]),
                    Gyro(date: Date(), type: .Gyro, value: [(2, 3, 4)]),
                    Gyro(date: Date(), type: .Accelerometer, value: [(3, 1, 0)])]
        
        self.gyros = data
    }
    
    func deleteGyro(_ gyro: Gyro) {
        guard let index = gyros.firstIndex(of: gyro) else { return }
        
        gyros.remove(at: index)
    }
}
