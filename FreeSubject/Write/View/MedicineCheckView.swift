//
//  MedicineCheckView.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/08/31.
//

import UIKit
import SnapKit
import Then

class MedicineCheckView: UIView {
    
    
    private let titleLabel = UILabel().then {
        $0.text = "약 복용"
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let takingMedicineButton = UIButton().then {
        $0.setImage(UIImage(named: "약복용"), for: .normal)
    }
    
    private let notTakingMedicineButton = UIButton().then {
        $0.setImage(UIImage(named: "약미복용"), for: .normal)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 14
        $0.distribution = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layer.backgroundColor = UIColor.customColor(.writeViewColor).cgColor
        self.layer.cornerRadius = 12
        setViewHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        addSubview(titleLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(notTakingMedicineButton)
        stackView.addArrangedSubview(takingMedicineButton)
    }
    
    private func setConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(8.84)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(58)
            $0.trailing.equalToSuperview().inset(7)
        }
        
    }
}
