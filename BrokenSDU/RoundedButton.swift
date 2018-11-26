//
//  RoundedButton.swift
//  BrokenSDU
//
//  Created by Emil Frisk on 23/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
