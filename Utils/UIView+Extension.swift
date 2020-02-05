//
//  UIView+Extension.swift
//  Utils
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

public extension UIView {

    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: Bundle(for: self))
    }

    func makeCircle() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }

}

