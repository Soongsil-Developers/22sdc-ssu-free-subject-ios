//
//  TemporaryViewController.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/09/04.
//

import Foundation
import Foundation
import SnapKit
import UIKit
import Realm
import Then

class TemporaryViewController:UIViewController{
    
    lazy var ButtonForNextView: UIButton = {
        var btn = UIButton()
        btn.setTitle("이전 페이지", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.66, alpha: 1.0)
        btn.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(ButtonForNextView)
        ButtonForNextView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func nextView(_ sender : Any){
        let view = CalendarViewController()
        view.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        view.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(view, animated: true, completion: nil)
    }
}

