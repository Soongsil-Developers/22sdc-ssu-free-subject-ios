//
//  EmotionalCheckView.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/08/31.
//

import UIKit
import SnapKit
import Then

class EmotionalCheckView: UIView {
    
    var EmotionalCheck : Bool?

    private let title = "하루 동안 유의미한 감정 기복이 있었어?"
    
    lazy var titleLabel = UILabel().then {
        $0.text = title
    }
    
    lazy var EmotionalCheckSwitch = UISwitch().then {
        //$0.isOn = true
        $0.onTintColor = UIColor.gray
        $0.addTarget(self, action: #selector(onClickSwitch(sender:)), for: .valueChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layer.backgroundColor = UIColor.green.cgColor
        self.layer.cornerRadius = 12
        setViewHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClickSwitch(sender: UISwitch) {
            EmotionalCheck = sender.isOn
            print(EmotionalCheck)
    }
   
    
    private func setViewHierarchy() {
        addSubview(titleLabel)
        addSubview(EmotionalCheckSwitch)
    }
    
    private func setConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(13)
        }
        
        EmotionalCheckSwitch.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.centerX.equalTo(titleLabel).offset(-47)
            $0.trailing.equalToSuperview().inset(6)
        }
        
    }

}
