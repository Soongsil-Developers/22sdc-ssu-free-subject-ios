//
//  EmojiView.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/08/28.
//

import UIKit
import SnapKit
import Then

enum Icon: CaseIterable {
    case Happy
    case Tranquility
    case Tough
    case Sad
    case Tired
    case Angry
    
    static var iconArray = [Happy,Tranquility,Tough,Sad,Tired,Angry]
    
    var image: UIImage {
        switch self {
        case .Happy: return UIImage(named: "Happy.png")!
        case .Tranquility: return UIImage(named: "Tranquility.png")!
        case .Tough: return UIImage(named: "Tough.png")!
        case .Sad: return UIImage(named: "Sad.png")!
        case .Tired: return UIImage(named: "Tired.png")!
        case .Angry: return UIImage(named: "Angry.png")!
        }
    }
    
    var labelText: String {
        switch self {
        case .Happy: return "기쁨"
        case .Tranquility: return "편안"
        case .Tough: return "힘듦"
        case .Sad: return "슬픔"
        case .Tired: return "피곤"
        case .Angry: return "화남"
        }
    }
}
class EmojiView: UIView {
    
    private let title = "기분을 선택해줘"
    
    lazy var titleLabel = UILabel().then {
        $0.text = title
    }
    
    lazy var horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layer.backgroundColor = UIColor.green.cgColor
        self.layer.cornerRadius = 12
        setViewHierarchy()
        setConstraints()
        setAddStackViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddStackViews() {
        
        for i in Icon.iconArray {
            let emojiStackView = EmojiStackView()
            emojiStackView.emojiLabel.text = i.labelText
            emojiStackView.emojiButton.setImage(i.image, for: .normal)
            emojiStackView.isActive = true
            horizontalStackView.addArrangedSubview(emojiStackView)
        }
        
    }
    
    private func setViewHierarchy() {
        addSubview(horizontalStackView)
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        
        horizontalStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(39)
            $0.leading.trailing.equalToSuperview().inset(14)
            
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(14)
        }
        
    }
}
