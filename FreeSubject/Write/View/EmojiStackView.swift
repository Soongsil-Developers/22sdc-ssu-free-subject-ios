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
    
    var isActive: Bool = false
    
    lazy var emojiButton = UIButton().then {_ in
    }
    
    lazy var emojiLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    lazy var stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fill
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayouts()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(emojiButton)
        stackView.addArrangedSubview(emojiLabel)
    }
    
    private func setConstraints() {
        
    }
}
