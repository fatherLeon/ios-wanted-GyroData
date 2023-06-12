//
//  Gyro.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

import Foundation

struct Gyro: Hashable {
    let id = UUID()
    let date: Date
    let type: GyroType
    let value: Double
}
