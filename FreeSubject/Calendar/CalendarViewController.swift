//
//  CalendarViewController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/08/27.

import Foundation
import SnapKit
import UIKit
import RealmSwift
import Then
import FSCalendar
import SwiftUI
import Charts



class CalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    
    
    let fsCalendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var selectedDate: Date = Date()
    let dateFormatter = DateFormatter()
    

    let titleLable:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.text = "app name"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    lazy var goToThisMonth:UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.uturn.left"), for: .normal)
        btn.addTarget(self, action: #selector(currentBtnClicked), for: .touchUpInside)
        btn.tintColor = .black
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
        return btn
    }()
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        setView()
        print("CalendarViewController")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        setView()
    }
    
    func setView(){
        view.backgroundColor = UIColor(red: 0.94, green: 0.97, blue: 0.95, alpha: 1.0)
        view.addSubview(titleLable)
        view.addSubview(fsCalendar)

        view.addSubview(goToThisMonth)
        fsCalendar.delegate = self
        fsCalendar.dataSource = self
    
        resetDB()
//        createDateDB()
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
        goToThisMonth.snp.makeConstraints{ make in
            make.top.equalTo(fsCalendar).inset(10)
            make.trailing.equalTo(fsCalendar).inset(15)
            make.width.equalTo(34)
            make.height.equalTo(34)
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
        fsCalendar.appearance.eventDefaultColor = UIColor.green
        fsCalendar.appearance.eventSelectionColor = UIColor.green
        fsCalendar.appearance.headerDateFormat = "MM월 YYYY년"

    }
    
    // 날짜 선택 -> 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("select")
        dateFormatter.dateFormat = "YYYY-MM-dd"
        print(dateFormatter.string(from: date))
        presentModalController(inputDate: dateFormatter.string(from: date))
        
    }
    
    // To be updated
    func presentModalController(inputDate:String) {
        let vc = CustomModalViewController()
        vc.Date = inputDate
        vc.modalPresentationStyle = .overCurrentContext
        // keep false
        // modal animation will be handled in VC itself
        self.present(vc, animated: false)
    }

    // 현재 달로 돌아오기 위한 함수
    @objc func currentBtnClicked(sender: UIButton!) {
        print(Date())   // 실제 오늘 날짜가 출력됨.
        self.fsCalendar.setCurrentPage(Date(), animated: true)
    }
    
    // Realm 생성
    func createDateDB(){
        let realm = try! Realm()
        let date1 = Day(Date: "2022-09-03", iconFeeling: "smile", sleepTime: "8:30", didFeelingChange: false, didTakeMedicine: true, tableNum: 2)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        try! realm.write{
            realm.add(date1)
        }
    }
    
    // 아예 Realm 파일 삭제 Realm 의 요소들을 변경하면 한번씩 해줘야 한다...
    func resetDB(){
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
          realmURL,
          realmURL.appendingPathExtension("lock"),
          realmURL.appendingPathExtension("note"),
          realmURL.appendingPathExtension("management")
        ]

        for URL in realmURLs {
          do {
            try FileManager.default.removeItem(at: URL)
          } catch {
            // handle error
          }
        }
    }

}
