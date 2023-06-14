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
        label.textAlignment = .center
        label.text = "x : 0"
        label.textColor = .systemRed
        
        return label
    }()
    private let yLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "y : 0"
        label.textColor = .systemGreen
        
        return label
    }()
    private let zLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "z : 0"
        label.textColor = .systemBlue
        
        return label
    }()
    
    private var xLayer: CALayer?
    private var yLayer: CALayer?
    private var zLayer: CALayer?
    
    private var graphDatas: [(x: Double, y: Double, z: Double)] = []

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
        
        drawWidthLineInGraphBackground(rect)
        drawHeightLineInGraphBackground(rect)
        drawGraph(rect)
    }
    
    func updateView(x: Double, y: Double, z: Double) {
        xLabel.text = "x : " + String(format: "%.2f", x)
        yLabel.text = "y : " + String(format: "%.2f", y)
        zLabel.text = "z : " + String(format: "%.2f", z)
        
        graphDatas.append((x, y, z))
        self.setNeedsDisplay()
    }
}

// MARK: Drawing
extension GraphView {
    private func drawGraph(_ rect: CGRect) {
        drawXGraph(rect)
        drawYGraph(rect)
        drawZGraph(rect)
    }
    
    private func drawXGraph(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let widthDiff = rect.width / 360
        let centerHeight = rect.height / 2
        
        context.beginPath()
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.systemRed.cgColor)
        
        context.move(to: CGPoint(x: 0, y: centerHeight))

        for (index, data) in graphDatas.enumerated() {
            context.addLine(to: CGPoint(x: widthDiff * CGFloat(index), y: centerHeight + data.x * 20))
        }
        
        context.drawPath(using: .stroke)
        context.closePath()
    }
    
    private func drawYGraph(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let widthDiff = rect.width / 360
        let centerHeight = rect.height / 2
        
        context.beginPath()
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.systemGreen.cgColor)
        
        context.move(to: CGPoint(x: 0, y: centerHeight))

        for (index, data) in graphDatas.enumerated() {
            context.addLine(to: CGPoint(x: widthDiff * CGFloat(index), y: centerHeight + data.y * 20))
        }
        
        context.drawPath(using: .stroke)
        context.closePath()
    }
    
    private func drawZGraph(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let widthDiff = rect.width / 360
        let centerHeight = rect.height / 2
        
        context.beginPath()
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.systemBlue.cgColor)
        
        context.move(to: CGPoint(x: 0, y: centerHeight))

        for (index, data) in graphDatas.enumerated() {
            context.addLine(to: CGPoint(x: widthDiff * CGFloat(index), y: centerHeight + data.z * 20))
        }
        
        context.drawPath(using: .stroke)
        context.closePath()
    }
    
    private func drawWidthLineInGraphBackground(_ rect: CGRect) {
        let widthPath = UIBezierPath()
        widthPath.lineWidth = 0.7
        let heightDiff = rect.height / 6
        
        for height in 0..<6 {
            widthPath.move(to: CGPoint(x: 0, y: CGFloat(height) * heightDiff))
            widthPath.addLine(to: CGPoint(x: rect.width, y: CGFloat(height) * heightDiff))
            
            widthPath.stroke()
        }

        widthPath.close()
    }
    
    private func drawHeightLineInGraphBackground(_ rect: CGRect) {
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
}

// MARK: UI
extension GraphView {
    private func configureViewUI() {
        let mainStackView = UIStackView(arrangedSubviews: [xLabel, yLabel, zLabel])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fillEqually
        
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
