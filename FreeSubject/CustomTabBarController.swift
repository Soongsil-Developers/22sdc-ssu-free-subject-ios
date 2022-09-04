//
//  CustomTabBarController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/08/28.
//

import Foundation
import UIKit
import SnapKit

class CustomTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // create instance
        let calendarVC = CalendarViewController()
        let statsVC = StatsViewController()
        // set title
        calendarVC.title = "달력"
        statsVC.title = "통계"
        // assign view controllers to tab bar
        self.setViewControllers([calendarVC,statsVC], animated: false)
        

        let imageCalendar = UIImage(named: "calendar")
        let imageStats = UIImage(named: "stats")
        guard let items = self.tabBar.items else {return}
        items[0].image = imageCalendar
        items[1].image = imageStats
        
    }
}
