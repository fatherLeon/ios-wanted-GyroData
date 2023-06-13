//
//  GyroType.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

enum GyroType {
    case Accelerometer
    case Gyro
    
    var text: String {
        switch self {
        case .Accelerometer:
            return "Acceleromter"
        case .Gyro:
            return "Gyro"
        }
    }
}
