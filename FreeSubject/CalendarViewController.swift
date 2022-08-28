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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
    }

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
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
        return btn
    }()

    lazy var myButtonNextRight: UIButton = {
        var btn = UIButton()
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
        return btn
    }()

    
    func setView(){
        view.backgroundColor = .systemBackground
        
        
        // for titleLabel
        self.view.addSubview(titleLable)
        titleLable.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-77)
            make.left.equalToSuperview().offset(77)
//            make.width.equalTo(200)
            make.height.equalTo(60)
        }

        
        // for Calendar
        let fsCalendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.addSubview(fsCalendar)
        fsCalendar.snp.makeConstraints{ make in
//            make.top.equalTo(titleLable.fs_bottom).inset(20)
//            make.left.equalTo(titleLable.fs_left)
//            make.right.equalTo(titleLable.fs_right)
//            make.leading.equalTo(titleLable.fs_left)
//            make.trailing.equalTo(titleLable.fs_right)
//            make.width.equalTo(titleLable)

            
            make.width.height.equalTo(400)
            make.center.equalToSuperview()
        }
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0.0  //양 옆 글자 투명도
        fsCalendar.dataSource = self
        fsCalendar.delegate = self
        fsCalendar.locale = Locale(identifier: "ko_KR")
        fsCalendar.scrollEnabled = true
        fsCalendar.appearance.weekdayTextColor = .black
        fsCalendar.appearance.headerTitleColor = .black
        
        // for Next month button
        view.addSubview(myButtonNextLeft)
        view.addSubview(myButtonNextRight)

        myButtonNextLeft.snp.makeConstraints{ make in
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





//// for PreView
//struct PreView: PreviewProvider {
//    static var previews: some View {
//        CalendarViewController().toPreview()
//    }
//}
//
//
//#if DEBUG
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//            let viewController: UIViewController
//
//            func makeUIViewController(context: Context) -> UIViewController {
//                return viewController
//            }
//
//            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//            }
//        }
//
//        func toPreview() -> some View {
//            Preview(viewController: self)
//        }
//}
//#endif


//    func calendarStyle(){
//        let calendarOrigin : FSCalendar = self.fsCalendar
//        //언어 한국어로 변경
//        calendarOrigin.locale = Locale(identifier: "ko_KR")
//        calendarOrigin.appearance.headerMinimumDissolvedAlpha = 0.0 // 투명도
//        //MARK: -상단 헤더 뷰 관련
//        calendarOrigin.headerHeight = 66 // YYYY년 M월 표시부 영역 높이
//        calendarOrigin.weekdayHeight = 41 // 날짜 표시부 행의 높이
//        calendarOrigin.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
//        calendarOrigin.appearance.headerDateFormat = "YYYY년 M월" //날짜(헤더) 표시 형식
//        calendarOrigin.appearance.headerTitleColor = .black //2021년 1월(헤더) 색
//        calendarOrigin.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24) //타이틀 폰트 크기
//
//
//        //MARK: -캘린더(날짜 부분) 관련
//        calendarOrigin.backgroundColor = .white // 배경색
//        calendarOrigin.appearance.weekdayTextColor = .black //요일(월,화,수..) 글씨 색
//        calendarOrigin.appearance.selectionColor =  UIColor(red: 0.74, green: 0.86, blue: 0.79, alpha: 1.00)
//        calendarOrigin.appearance.titleWeekendColor = .black //주말 날짜 색
//        calendarOrigin.appearance.titleDefaultColor = .black //기본 날짜 색
//
//
//        //MARK: -오늘 날짜(Today) 관련
//        calendarOrigin.appearance.titleTodayColor = UIColor(red: 0.26, green: 0.49, blue: 0.09, alpha: 1.00) //Today에 표시되는 특정 글자색
//        calendarOrigin.appearance.todayColor = .clear //Today에 표시되는 선택 전 동그라미 색
//        calendarOrigin.appearance.todaySelectionColor = .none  //Today에 표시되는 선택 후 동그라미 색
//
//
//        // Month 폰트 설정
//        calendarOrigin.appearance.headerTitleFont = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
//        // day 폰트 설정
//        calendarOrigin.appearance.titleFont = UIFont(name: "Roboto-Regular", size: 14)
//
//        // scroll able
//        calendarOrigin.scrollEnabled = true
//
//    }
