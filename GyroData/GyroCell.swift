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
        
        configureViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(by date: Date, type: String, data: String) {
        dateLabel.text = date.description
        motionTypeLabel.text = type
        valueLabel.text = data
    }
}

// MARK: UI
extension GyroCell {
    private func configureViewUI() {
        let infoStackView = UIStackView(arrangedSubviews: [dateLabel, motionTypeLabel])
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        
        let mainStackView = UIStackView(arrangedSubviews: [infoStackView, dateLabel])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.spacing = 8
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
