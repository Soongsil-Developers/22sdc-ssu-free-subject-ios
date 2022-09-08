//
//  WriteViewController.swift
//  FreeSubject
//
//
//

import UIKit
import SnapKit
import Then

class WriteViewController: UIViewController {
    
    // 입력값 필수 체크
    var isMedicineCheckRight: Bool = false
    var isSleepTimeCheckRight: Bool = false
    var isTodayQuestionCheckRight: Bool = false
    
    // 약복용 여부
    var medicineCheck: Bool?
    // 수면 시간
    var sleepTime: String?
    // 3번째 질문
    var questionText: String?
    
    let emojiView = EmojiView()
    let sleepTimeDatePickerView = SleepTimeDatePickerView()
    let medicineCheckView = MedicineCheckView()
    let emotionalCheckView = EmotionalCheckView()
    let contentScrollView = ContentScrollView()
    let todayQuestionView = TodayQuestionView()
    
    lazy var saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.isEnabled = false
        $0.setBackgroundColor(.customColor(.writeViewColor), for: .normal)
        $0.setBackgroundColor(.gray, for: .disabled)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(saveButtonTap(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentScrollView.medicineCheckView.delegate = self
        contentScrollView.sleepTimeDatePickerView.delegate = self
        contentScrollView.todayQuestionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveButtonEnableCheck(_:)),
            name: Notification.Name("saveButtonEnable"),
            object: nil
        )
        
        setUI()
    }
    
    func setUI() {
        self.view.addSubview(contentScrollView)
        self.view.addSubview(saveButton)
        
        contentScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(260)
            $0.bottom.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
            $0.trailing.leading.equalToSuperview().inset(130)
            $0.height.equalTo(44)
        }
    }
    
    
    @objc func saveButtonEnableCheck(_ noti: Notification) {
        saveButton.isEnabled = isMedicineCheckRight && isSleepTimeCheckRight && isTodayQuestionCheckRight
    }
    
    @objc func saveButtonTap(_ sender: UIButton) {
        print(sender.isEnabled)
    }
}
extension WriteViewController: MedicineCheckDelegate, SleepTimeCheckDelegate, TodayQuestionCheckDelegate {
    
    func SleepTimeCheckEnabledSaveBtn(sleepTime: String) {
        self.sleepTime = sleepTime
        
        if self.sleepTime != "" {
            self.isSleepTimeCheckRight = true
            
            NotificationCenter.default.post(
                name: Notification.Name("saveButtonEnable"),
                object: nil
            )
        }
    }
    
    func medicineCheckEnabledSaveBtn(medicine: Bool) {
        
        self.medicineCheck = medicine
        
        if self.medicineCheck != nil {
            self.isMedicineCheckRight = true
            
            NotificationCenter.default.post(
                name: Notification.Name("saveButtonEnable"),
                object: nil
            )
        }
    }
    
    func TodayQuestionCheckEnabledSaveBtn(question: String) {
        
        self.questionText = question
        
        if self.questionText != "" {
            self.isTodayQuestionCheckRight = true
            
            NotificationCenter.default.post(
                name: Notification.Name("saveButtonEnable"),
                object: nil
            )
        }
    }
}

