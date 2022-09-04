//
//  UIStackView+.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/09/03.
//

import UIKit.UIStackView

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

