//
//  JsonGyroModel.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/15.
//

import Foundation

struct JsonGyroModel: Codable {
    let id: UUID
    let date: Date
    let type: String
    let xValue: [Double]
    let yValue: [Double]
    let zValue: [Double]
}
