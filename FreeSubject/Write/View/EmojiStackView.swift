//
//  EmojiButton.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/08/29.
//

import UIKit
import SnapKit
import Then

class EmojiStackView: UIView {
    
     var emoji: Emoji?
    
     var emojiButton = UIButton()
    
     var emojiLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    private let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fill
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero) //오토레이아웃으로 잡는다는 이야기
        setViewHierarchy()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(emojiButton)
        stackView.addArrangedSubview(emojiLabel)
    }
    
    private func setConstraints() {
        
    }
    
    func configure(emoji:Emoji) {
        self.emoji = emoji
        emojiLabel.text = emoji.labelText
        emojiButton.setImage(emoji.image, for: .normal)
        
    }
    
    //선택메서드 -> 델리게이트 불러서 파라미터에 self.icon을 넣는다.
    
    func emojiTap() {
        
    }
}
