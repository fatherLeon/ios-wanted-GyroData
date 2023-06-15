//
//  DatabaseError.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/15.
//

import Foundation

enum DatabaseError: LocalizedError {
    case saveError
    case nonGyroData
    case nonCorrectURL
    
    var errorDescription: String? {
        switch self {
        case .saveError:
            return "데이터베이스 저장에 실패하였습니다."
        case .nonGyroData:
            return "측정된 데이터가 존재하지 않습니다."
        case .nonCorrectURL:
            return "저장된 데이터가 없습니다."
        }
    }
}
