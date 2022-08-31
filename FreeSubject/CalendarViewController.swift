//
//  CalendarViewController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/08/27.

import Foundation
import SnapKit
import UIKit
import Realm
import Then
import FSCalendar
import SwiftUI


class CalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{

    let fsCalendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let titleLable:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
        label.text = "AppName"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    lazy var myButtonNextLeft: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.addTarget(self, action: #selector(previousMonthAction), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
        return btn
    }()
    lazy var myButtonNextRight: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btn.addTarget(self, action: #selector(nextMonthAction), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()

    }

    
    func setView(){
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLable)
        view.addSubview(fsCalendar)
        fsCalendar.addSubview(myButtonNextLeft)
        fsCalendar.addSubview(myButtonNextRight)
    
        setSNP()
        
    }
    
    func setSNP(){
        calendarSetting()
        fsCalendar.snp.makeConstraints{ make in
            make.top.equalTo(titleLable.fs_bottom).inset(150)
            make.leading.equalTo(titleLable.fs_left).inset(20)
            make.trailing.equalTo(titleLable.fs_right).inset(20)
            make.bottom.equalToSuperview().offset(-200)
        }
        myButtonNextLeft.snp.makeConstraints{ make in
            make.top.equalTo(fsCalendar)
            make.leading.equalTo(fsCalendar)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        myButtonNextRight.snp.makeConstraints{ make in
            make.top.equalTo(fsCalendar)
            make.trailing.equalTo(fsCalendar)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        titleLable.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(77)
            make.trailing.equalToSuperview().offset(-77)
            make.height.equalTo(60)
        }
    }
    
    func calendarSetting(){
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0.0  //양 옆 글자 투명도
        fsCalendar.dataSource = self
        fsCalendar.delegate = self
        fsCalendar.locale = Locale(identifier: "ko_KR")
        fsCalendar.scrollEnabled = true
        fsCalendar.appearance.weekdayTextColor = .black
        fsCalendar.appearance.headerTitleColor = .black
    }

    @objc func nextMonthAction(sender: UIButton!) {
        let currentDay = fsCalendar.currentPage
        var components = DateComponents()
        let calendar = Calendar(identifier: .gregorian)
        components.month = 1    // 다음 달 이동
        let nextDay = calendar.date(byAdding: components, to: currentDay)!
        fsCalendar.setCurrentPage(nextDay, animated: true)
    }
    
    @objc func previousMonthAction(sender: UIButton!) {
        let currentDay = fsCalendar.currentPage
        var components = DateComponents()
        let calendar = Calendar(identifier: .gregorian)
        components.month = -1   // 이전 달 이동
        let nextDay = calendar.date(byAdding: components, to: currentDay)!
        fsCalendar.setCurrentPage(nextDay, animated: true)
    }

}


