//
//  File.swift
//  AlarmClock
//
//  Created by Fai Wu on 3/23/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

extension UIView {
    func fadeIn() {
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 0.5
        }, completion: nil)
    }
}
