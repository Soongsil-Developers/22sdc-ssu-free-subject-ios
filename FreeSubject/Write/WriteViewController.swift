//
//  WriteViewController.swift
//  FreeSubject
//
//
//

import UIKit
import SnapKit
import Then
import RealmSwift
import Realm

class WriteViewController: UIViewController {
    
    var todayTask: Day?
    
    var stdDate: String?
    
    let calendar: Calendar = Calendar.current
    
    // 입력값 필수 체크
    var isEmojiCheckRight: Bool = false
    var isMedicineCheckRight: Bool = false
    var isSleepTimeCheckRight: Bool = false
    var isTodayQuestionCheckRight: Bool = false
    
    //이모지
    var getEmoji: String?
    // 약복용 여부
    var medicineCheck: Bool?
    // 수면 시간
    var sleepTime: String?
    // 기분 체크
    var emotionCheck: Bool?
    // 1번째 질문
    var firstQuestion: String?
    // 2번째 질문
    var secondQuestion: String?
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
        contentScrollView.emojiView.delegate = self
        contentScrollView.medicineCheckView.delegate = self
        contentScrollView.sleepTimeDatePickerView.delegate = self
        contentScrollView.emotionalCheckView.delegate = self
        contentScrollView.todayQuestionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonEnableCheck(_:)), name: Notification.Name("saveButtonEnable"), object: nil)
        setUI()
    }
    
    func setUI() {
        self.view.addSubview(contentScrollView)
        self.view.addSubview(saveButton)
        
        contentScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(200)
            $0.bottom.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
            $0.trailing.leading.equalToSuperview().inset(130)
            $0.height.equalTo(44)
        }
    }
    
    func saveData() {
        let currentDate = Date()
        let newTask = Day(createdDate: currentDate,
                          iconFeeling: getEmoji!,
                          sleepTime: sleepTime!,
                          didFeelingChange: emotionCheck ?? false,
                          didTakeMedicine: medicineCheck!,
                          firstQuestion: firstQuestion ?? "불편한 거 없이 좋았어요.",
                          secondQuestion: secondQuestion ?? "특별한 사건이 없었어요.",
                          thirdQuestion: questionText!)
        
        if calendar.isDateInToday(currentDate) {
            if self.todayTask?._id == nil {
                RealmService.shared.add(item: newTask)
                
            } else {
                guard let task = self.todayTask else { return }
                
                RealmService.shared.update(item: task, newTask: newTask)
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -250 // Move view 150 points upward

    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
        // Move view to original position
    }
    
    
    
    @objc func saveButtonEnableCheck(_ noti: Notification) {
        saveButton.isEnabled = isMedicineCheckRight && isSleepTimeCheckRight && isTodayQuestionCheckRight && isEmojiCheckRight
    }
    
    @objc func saveButtonTap(_ sender: UIButton) {
        print(sender.isEnabled)
        saveData()
        self.dismiss(animated: true)
    }
}
extension WriteViewController: MedicineCheckDelegate, SleepTimeCheckDelegate, TodayQuestionCheckDelegate, EmotionalCheckDelegate, EmojiViewCheckDelegate {

    func getEmoji(emoji: String) {
        self.getEmoji = emoji
        
        if self.getEmoji != "" {
            self.isEmojiCheckRight = true
        }
        
    }
    
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
    
    func firstQuestionText(firstQuestion: String) {
        self.firstQuestion = firstQuestion
    }
    
    func secondQuestionText(secondQuestion: String) {
        self.secondQuestion = secondQuestion
    }
    
    func emotionalCheck(emotional:Bool) {
        self.emotionCheck = emotional
    }
}

