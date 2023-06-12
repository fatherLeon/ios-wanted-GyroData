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
        label.font = .preferredFont(forTextStyle: .caption2)
        label.numberOfLines = 1
        
        return label
    }()
    private let motionTypeLabel: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        
        return label
    }()
    private let valueLabel: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
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
    
    func apply(by date: Date, type: String, data: Double) {
        dateLabel.text = date.cellText
        motionTypeLabel.text = type
        valueLabel.text = String(format: "%.1f", data)
    }
}

// MARK: UI
extension GyroCell {
    private func configureViewUI() {
        let infoStackView = UIStackView(arrangedSubviews: [dateLabel, motionTypeLabel])
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.spacing = 20
        infoStackView.axis = .vertical
        
        let mainStackView = UIStackView(arrangedSubviews: [infoStackView, valueLabel])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.distribution = .equalSpacing
        mainStackView.spacing = 50
        mainStackView.axis = .horizontal
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
