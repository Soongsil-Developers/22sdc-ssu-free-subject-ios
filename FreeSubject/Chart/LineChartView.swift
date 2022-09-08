//
//  LineChartView.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/09/07.
//

import Foundation
import Foundation
import UIKit

class LineChartView: UIView {
    
    var values: [CGFloat] = []
    
    var graphPath: UIBezierPath!
    var zeroPath: UIBezierPath!
    var animated: Bool!
    
    let graphLayer = CAShapeLayer()

    init(frame: CGRect, values: [CGFloat], animated: Bool) {
        super.init(frame: frame)
        self.values = values
        self.animated = animated
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.graphPath = UIBezierPath()
        self.zeroPath = UIBezierPath()
        
        self.layer.addSublayer(graphLayer)

        let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
        
        var currentX: CGFloat = 0
        let startPosition = CGPoint(x: currentX, y: self.frame.height)
        self.graphPath.move(to: startPosition)
        self.zeroPath.move(to: startPosition)
        
        for i in 0..<values.count {
            currentX += xOffset
            let newPosition = CGPoint(x: currentX,
                                      y: self.frame.height - self.values[i])
            self.graphPath.addLine(to: newPosition)
            self.zeroPath.addLine(to: CGPoint(x: currentX, y: self.frame.height))
        }
        
        graphLayer.fillColor = nil
        graphLayer.strokeColor = UIColor(red: 0.93, green: 0.67, blue: 0.63, alpha: 1.0).cgColor
        graphLayer.lineWidth = 3

        let oldPath = self.zeroPath.cgPath
        let newPath = self.graphPath.cgPath
            
        // animation action
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.9
        animation.fromValue = oldPath
        animation.toValue = newPath
        self.graphLayer.path = newPath
        self.graphLayer.add(animation, forKey: "path")
    }
}
