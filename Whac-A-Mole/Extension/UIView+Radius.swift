//
//  UIView+Radius.swift
//  Whac-A-Mole
//
//  Created by RedScor Yuan on 2018/1/31.
//  Copyright © 2018年 RedScor. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
