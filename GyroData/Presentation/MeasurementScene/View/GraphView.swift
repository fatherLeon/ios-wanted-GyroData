//
//  GraphView.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/13.
//

import UIKit

final class GraphView: UIView {
    
    private let xLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .systemRed
        
        return label
    }()
    private let yLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .systemGreen
        
        return label
    }()
    private let zLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .systemBlue
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

extension GraphView {
    private func configureViewUI() {
        let mainStackView = UIStackView(arrangedSubviews: [xLabel, yLabel, zLabel])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
