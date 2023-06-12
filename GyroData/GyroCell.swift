//
//  GyroCell.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/12.
//

import UIKit

class GyroCell: UITableViewCell {
    
    static let identifier = "GyroCell"
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 12)
        label.numberOfLines = 1
        
        return label
    }()
    private let motionTypeLabel: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 18)
        label.numberOfLines = 1
        
        return label
    }()
    private let valueLabel: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 24)
        label.numberOfLines = 1
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
