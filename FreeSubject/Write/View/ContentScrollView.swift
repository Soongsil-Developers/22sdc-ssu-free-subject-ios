//
//  ContentScrollView.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/08/31.
//

import UIKit
import SnapKit
import Then

class ContentScrollView: UIView {
    
    private let scrollView = UIScrollView().then {
        $0.automaticallyAdjustsScrollIndicatorInsets = false
    }
    
    private let contentView = UIView().then {
        $0.layer.backgroundColor = UIColor.white.cgColor
    }
    
    let contentGrayView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.backgroundColor = UIColor.customColor(.defaultGrayColor).cgColor
    }
    
    private let emojiView = EmojiView()
    
    private let sleepTimeDatePickerView = SleepTimeDatePickerView()
    
    private let medicineCheckView = MedicineCheckView()
    
    //sleepTimeDatePickerView와 medicineCheckView 합친 horizontal StackView
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 7
        $0.distribution = .fillEqually
    }
    
    private let emotionalCheckView = EmotionalCheckView()
    
    private let todayQuestionView = TodayQuestionView()
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
       
       override init(frame: CGRect) {
           super .init(frame: .zero)
           setViewHierarchy()
           setConstraints()
       }
    
    private func setViewHierarchy() {
        
        stackView.addArrangedSubviews(sleepTimeDatePickerView, medicineCheckView)
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(contentGrayView)
        
        contentGrayView.addSubviews(emojiView, stackView, emotionalCheckView, todayQuestionView)
    }
    private func setConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        
        contentView.snp.makeConstraints {
           $0.top.equalTo(scrollView.snp.top)
           $0.bottom.equalTo(scrollView.snp.bottom)
           $0.width.equalTo(scrollView.snp.width)
        }
        
        contentGrayView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        emojiView.snp.makeConstraints {
            $0.height.equalTo(121)
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(emojiView.snp.bottom).offset(9)
        }
        
        emotionalCheckView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(stackView.snp.bottom).offset(9)
        }
        
        todayQuestionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(emotionalCheckView.snp.bottom).offset(21)
            $0.bottom.equalToSuperview().inset(37)
        }
    }
}
