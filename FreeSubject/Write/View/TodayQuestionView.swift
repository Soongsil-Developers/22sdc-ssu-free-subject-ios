//
//  TodayQuestionView.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/09/03.
//

import UIKit
import SnapKit
import Then

class TodayQuestionView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.text = "오늘의 질문"
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let firstQuestionLabel = UILabel().then {
        $0.text = "1. 약을 먹고 불편한 것이 있다면 자세히 알려줘"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    private let firstQuestionTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = true
        $0.sizeToFit()
        $0.isScrollEnabled = false
    }
    
    private let firstQuestionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 9
        $0.distribution = .fill
    }
    
    private let secondQuestionLabel = UILabel().then {
        $0.text = "2. 특별한 생활 사건들에 대해 자세히 알려줘"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    private let secondQuestionTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = true
        $0.sizeToFit()
        $0.isScrollEnabled = false
    }
    
    private let secondQuestionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 9
        $0.distribution = .fill
    }
    
    private let thirdQuestionLabel = UILabel().then {
        $0.text = "3. 오늘 하루를 떠올리고 아래 표에서 어울리는 나의 상태를 골라줘"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var thirdQuestionTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.tintColor = UIColor.gray
        $0.layer.backgroundColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 5
        $0.sizeToFit()
        $0.placeholder = "나의 상태를 골라주세요"
        $0.snp.makeConstraints {
            $0.height.equalTo(30)
        }
    }
    
    private let thirdQuestionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 9
        //$0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let thirdQuestionPicker = UIPickerView() //질문뷰에서 구현
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 29
        $0.distribution = .fill
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViewHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        firstQuestionStackView.addArrangedSubviews(firstQuestionLabel, firstQuestionTextView)
        
        secondQuestionStackView.addArrangedSubviews(secondQuestionLabel, secondQuestionTextView)
        
        thirdQuestionStackView.addArrangedSubviews(thirdQuestionLabel, thirdQuestionTextField)
        
        verticalStackView.addArrangedSubviews(firstQuestionStackView, secondQuestionStackView, thirdQuestionStackView)
        
        addSubviews(titleLabel, verticalStackView)
    }
    
    private func setConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(13)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
        }
        
    }
}

