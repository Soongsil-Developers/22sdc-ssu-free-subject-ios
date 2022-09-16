//
//  LineChartViewController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/09/07.
//

import Foundation
import UIKit
import QuartzCore
import RealmSwift

class LineChartViewController: UIViewController, LineChartDelegate {

    var label = UILabel()
    var lineChart: LineChart!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        read()
        view.backgroundColor = UIColor(red: 0.94, green: 0.97, blue: 0.95, alpha: 1.0)
        var views: [String: AnyObject] = [:]
        
        label.text = "9월 누적 통계입니다."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        // simple arrays
        let data: [CGFloat] = [3, 4, -2, 11, 13, 15]
//        let data2: [CGFloat] = [1, 3, 5, 13, 17, 20]
        
        // simple line with custom x axis labels
        let xLabels: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun","hi"]
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 5
        lineChart.x.labels.values = xLabels
        lineChart.y.labels.visible = true
        lineChart.addLine(data)
//        lineChart.addLine(data2)
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
        self.view.addSubview(lineChart)
        views["chart"] = lineChart
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-[chart(==200)]", options: [], metrics: nil, views: views))
        
//        var delta: Int64 = 4 * Int64(NSEC_PER_SEC)
//        var time = dispatch_time(DISPATCH_TIME_NOW, delta)
//
//        dispatch_after(time, dispatch_get_main_queue(), {
//            self.lineChart.clear()
//            self.lineChart.addLine(data2)
//        });
        
//        var scale = LinearScale(domain: [0, 100], range: [0.0, 100.0])
//        var linear = scale.scale()
//        var invert = scale.invert()
//        println(linear(x: 2.5)) // 50
//        println(invert(x: 50)) // 2.5
        
    }
    
    
    var inputNumForChart:[Int] = []
    var DateSortResult:[Int] = []
    
    struct DataForChart{
        var Date:Int = 0
        var inputNum:Int = 0
    }
    
    var ArrayForNum:[DataForChart] = []
    
    private func read() {
        guard let realm = try? Realm() else { return }
        let models = realm.objects(Day.self)
        for model in models {
            inputNumForChart += [model.iconFeeling]
            let mdl = DataForChart(Date: Int(model.createdDate) ?? 000000, inputNum: model.iconFeeling)
            ArrayForNum += [mdl]
        }
        // createdDate 을 String -> Int 로 변환하고 날짜를 기준으로 오름차순
        let newArrayForChart = ArrayForNum.sorted(by:{$0.Date < $1.Date})
        print(newArrayForChart)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /**
     * Line chart delegate method.
     */
    func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>) {
        label.text = "x: \(x)     y: \(yValues)"
    }
    
    
    
    /**
     * Redraw chart on device rotation.
     */
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }

}
