//
//  UIView+.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/09/03.
//

import UIKit.UIView

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}


