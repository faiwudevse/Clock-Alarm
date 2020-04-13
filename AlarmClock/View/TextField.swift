//
//  TextField.swift
//  AlarmClock
//
//  Created by Fai Wu on 3/19/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
