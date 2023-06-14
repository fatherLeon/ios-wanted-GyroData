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
        
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 2.5
        
        UIColor.systemBackground.setFill()
        
        let path = UIBezierPath(rect: rect)
        path.fill()
        path.close()
        
        let widthPath = UIBezierPath()
        widthPath.lineWidth = 0.7
        let heightDiff = rect.height / 6
        
        for height in 0..<6 {
            widthPath.move(to: CGPoint(x: 0, y: CGFloat(height) * heightDiff))
            widthPath.addLine(to: CGPoint(x: rect.width, y: CGFloat(height) * heightDiff))
            
            widthPath.stroke()
        }

        widthPath.close()
        
        let heightPath = UIBezierPath()
        heightPath.lineWidth = 0.7
        let widthDiff = rect.width / 6
        
        for width in 0..<6 {
            heightPath.move(to: CGPoint(x: CGFloat(width) * widthDiff, y: 0))
            heightPath.addLine(to: CGPoint(x: CGFloat(width) * widthDiff, y: rect.width))
            
            heightPath.stroke()
        }
        
        heightPath.close()
    }
    
    func updateView(x: Double, y: Double, z: Double) {
        xLabel.text = String(format: "%.2f", x)
        yLabel.text = String(format: "%.2f", y)
        zLabel.text = String(format: "%.2f", z)
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
