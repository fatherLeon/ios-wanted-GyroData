//
//  MainViewModel.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

import Combine
import Foundation

final class MainViewModel {
    private let coredataManager = CoreDataManager()
    @Published var gyros: [Gyro] = []
    var cancellables: [AnyCancellable] = []
    
    init() {
    }
    
    func deleteGyro(_ gyro: Gyro) {
        guard let index = gyros.firstIndex(of: gyro) else { return }
        
        gyros.remove(at: index)
    }
    
    private func searchData() {
        let gyroInfos = coredataManager.read()
        
        gyroInfos.forEach { info in
            guard let url = info.url,
                  let data = try? Data(contentsOf: url),
                  let decodingData = try? JSONDecoder().decode(Gyro.self, from: data) else { return }
            
            self.gyros.append(decodingData)
        }
    }
}
