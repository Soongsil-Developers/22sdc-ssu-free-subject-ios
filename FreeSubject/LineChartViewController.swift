//
//  LineChartViewController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/09/07.
//

import Foundation
import UIKit
class LineChartViewController: UIViewController {

    var graphView: LineChartView!

    override func viewDidLoad() {
        print("LineChartViewController")
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width-10, height: self.view.frame.height - 300)
        let view = LineChartView(frame: frame,
                                     values: [500,300, 500, 100, 50, 0],
                                     // 0이 가장 작은값, 500이 가장 큰값
                                     animated: false)
        view.backgroundColor = UIColor(red: 0.83, green: 0.92, blue: 0.87, alpha: 1.0)
        view.center = CGPoint(x: self.view.frame.size.width  / 2,
                              y: self.view.frame.size.height / 2)
        self.view.addSubview(view)
        self.graphView = view
    }

}

