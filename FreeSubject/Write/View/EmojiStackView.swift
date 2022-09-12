//
//  EmojiButton.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/08/29.
//

import UIKit
import SnapKit
import Then

protocol EmojiStackViewDelegate: AnyObject {
    func didSelectedEmojiView(newEmoji:Emoji)
}

class EmojiStackView: UIButton {
    
    var emoji: Emoji?
    
    weak var delegate: EmojiStackViewDelegate?
    
    override var isHighlighted: Bool {
        didSet {
            if oldValue {
            emojiTap()
            }
        }
    }
    
    private var emojiImageView = UIImageView().then{
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
    }
    
    private var emojiLabel = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    
    func addBorder() {
        emojiImageView.layer.borderWidth = 2
        emojiImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    func removeBorder() {
        emojiImageView.layer.borderWidth = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame) //오토레이아웃으로 잡는다는 이야기
        setViewHierarchy()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        addSubviews(emojiImageView, emojiLabel)
    }
    
    private func setConstraints() {
    
            emojiLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview()
            }
            
            emojiImageView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(emojiLabel.snp.top).offset(-8)
            }
        }
    
    func configure(emoji:Emoji) {
        self.emoji = emoji
        emojiLabel.text = emoji.labelText
        emojiImageView.image = emoji.image
    }
    
    //선택메서드 -> 델리게이트 불러서 파라미터에 self.icon을 넣는다.
    
    func emojiTap() {
        
        guard let emoji = emoji else { return }
        
        self.delegate?.didSelectedEmojiView(newEmoji:emoji)
    }
}
