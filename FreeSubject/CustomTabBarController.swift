//
//  CustomTabBarController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/08/28.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = CalendarViewController()
        vc1.title = "캘린더"
        vc1.navigationItem.largeTitleDisplayMode = .always
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.navigationBar.prefersLargeTitles = true
        setViewControllers([vc1], animated: false)
        

    }
}



