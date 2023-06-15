//
//  JsonGyroModel.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/15.
//

import Foundation

struct Gyro: Codable, Hashable {
    let id: UUID
    let date: Date
    let type: GyroType
    var xValue: [Double] = []
    var yValue: [Double] = []
    var zValue: [Double] = []
    
    enum GyroType: String, Codable {
        case Accelerometer = "Acceleromter"
        case Gyro = "Gyro"
        
        var text: String {
            switch self {
            case .Accelerometer:
                return "Acceleromter"
            case .Gyro:
                return "Gyro"
            }
        }
    }
}
