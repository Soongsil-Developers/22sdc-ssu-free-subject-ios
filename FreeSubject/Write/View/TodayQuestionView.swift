//
//  TodayQuestionView.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/09/03.
//

import UIKit
import SnapKit
import Then

protocol TodayQuestionCheckDelegate: AnyObject {
    func TodayQuestionCheckEnabledSaveBtn(question: String)
}

class TodayQuestionView: UIView {
    
   
    
  var question = ["극도로 심한 들끔으로 입원중에도 증상 조절이 안도니느 상태이다. 10", "극도로 들뜸, 환청이나 망상이 심하여 입원을 요하는 상태다 7", "감당하기 힘들 만큼 일을 벌이고 기고만장하다. 4","오버한다, 나선다, 설친다, 자신감이 지나치다. 3", "말이나 하고싶은게 많고 의욕, 자신감이 차있다. 2", "기분이 좋고, 즐겁고, 신나고 의욕적이다. 1", "기분이 보통이고 편안한 상태. 0", "시큰둥하고 의욕이 다소 떨어지나, 할 일은 다 한다. -1"]
    
    var text = ""
    
    weak var delegate: TodayQuestionCheckDelegate?
    
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
    
    let firstQuestionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 9
        $0.distribution = .fill
    }
    
    private let secondQuestionLabel = UILabel().then {
        $0.text = "2. 특별한 생활 사건들에 대해 자세히 알려줘"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let secondQuestionTextView = UITextView().then {
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
        $0.text = text
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
        $0.distribution = .fill
    }
    
    let questionPicker = UIPickerView()
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 29
        $0.distribution = .fill
        
    }
    
    func configPickerView() {
        questionPicker.delegate = self
        questionPicker.dataSource = self
        thirdQuestionTextField.inputView = questionPicker
    }
    
    func configToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
    
        toolBar.setItems([done], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        thirdQuestionTextField.inputAccessoryView = toolBar
    }

    @objc func donePicker() {
        let row = self.questionPicker.selectedRow(inComponent: 0)
        self.questionPicker.selectRow(row, inComponent: 0, animated: false)
        self.thirdQuestionTextField.text = self.question[row]
        self.thirdQuestionTextField.resignFirstResponder()
        self.delegate?.TodayQuestionCheckEnabledSaveBtn(question: thirdQuestionTextField.text!)
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViewHierarchy()
        setConstraints()
        configPickerView()
        configToolbar()
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

extension TodayQuestionView: UIPickerViewDelegate, UIPickerViewDataSource {
        
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return question.count
        
        
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return question[row]
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.thirdQuestionTextField.text = self.question[row]
    }
}
