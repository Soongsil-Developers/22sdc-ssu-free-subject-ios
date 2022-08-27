//
//  CalendarViewController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/08/27.
//


import Foundation
import SnapKit
import UIKit
import Realm
import Then
import FSCalendar


class CalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setBaseView()
        setView()
        
    }
    
    let safetyArea: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    fileprivate weak var fsCalendar:FSCalendar!
    override func loadView() {
        let view = UIView(frame:UIScreen.main.bounds)
        self.view = view
    }
    
    lazy var myButtonNextLeft: UIButton = {
        let btn = UIButton()
        btn.setTitle("다음달", for: .normal)
        btn.backgroundColor = UIColor.blue
        return btn
    }()
    
    lazy var myButtonNextRight: UIButton = {
        let btn = UIButton()
        btn.setTitle("다음달", for: .normal)
        btn.backgroundColor = UIColor.blue
        return btn
    }()
  
    func setBaseView(){
        safetyArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safetyArea)
        if #available(iOS 13, *) {
            let guide = view.safeAreaLayoutGuide
            safetyArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            safetyArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            safetyArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            safetyArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            
        } else {
            safetyArea.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
            safetyArea.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
            safetyArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            safetyArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
    func setView(){
        view.backgroundColor = .white
        let fsCalendar = FSCalendar(frame: CGRect(x: 20, y: 150, width: 320, height: 400))
        // fsCalender autolayout??
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0.0  //양 옆 글자 투명도
        fsCalendar.dataSource = self
        fsCalendar.delegate = self
        view.addSubview(fsCalendar)
        self.fsCalendar = fsCalendar
        
        view.addSubview(myButtonNextLeft)
        view.addSubview(myButtonNextRight)
        myButtonNextLeft.snp.makeConstraints{ (make) in
            make.top.equalTo(fsCalendar)
            make.left.equalTo(fsCalendar)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        myButtonNextRight.snp.makeConstraints{ (make) in
            make.top.equalTo(fsCalendar)
            make.right.equalTo(fsCalendar)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        
    }
    
}
