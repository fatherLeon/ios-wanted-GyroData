//
//  Date++Extension.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

import Foundation

extension Date {
    static private let cellDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY/MM/DD HH:mm:ss"
        dateFormatter.locale = Locale.current
        
        return dateFormatter
    }()
    
    var cellText: String {
        return Date.cellDateFormatter.string(from: self)
    }
}
