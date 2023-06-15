//
//  Gyro.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

import Foundation

struct Gyro: Hashable {
    static func == (lhs: Gyro, rhs: Gyro) -> Bool {
        return lhs.id == rhs.id
    }

    var hashValue: Int {
        return id.hashValue
    }
    
    let id = UUID()
    let date: Date
    let type: GyroType
    var value: [(x: Double, y: Double, z: Double)] = []
}
