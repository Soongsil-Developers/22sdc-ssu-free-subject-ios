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
    
    override var isSelected: Bool {
        didSet {
            emojiTap()
        }
    }
    
    private var emojiImageView = UIButton()
    
    private var emojiLabel = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    private let stackView = UIStackView().then {
        $0.layer.cornerRadius = 24.5
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fill
        $0.isUserInteractionEnabled = true
        
    }
    
    func addBorder() {
        stackView.layer.borderWidth = 3
        stackView.layer.borderColor = UIColor.black.cgColor
    }
    
    func removeBorder() {
        stackView.layer.borderWidth = 0
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
        stackView.addArrangedSubview(emojiImageView)
        stackView.addArrangedSubview(emojiLabel)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(emoji:Emoji) {
        self.emoji = emoji
        emojiLabel.text = emoji.labelText
        emojiImageView.setImage(emoji.image, for: .normal)
        //emojiImageView.image = emoji.image
    }
    
    //선택메서드 -> 델리게이트 불러서 파라미터에 self.icon을 넣는다.
    
    func emojiTap() {
        
        
        
        guard let emoji = emoji else {
            return
        }
        
        self.delegate?.didSelectedEmojiView(newEmoji:emoji)
    }
}
