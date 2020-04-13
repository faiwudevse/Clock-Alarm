//
//  customNavigationController.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/18/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit

class CustomNaviController : UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        setupNavigationBarStyles()
    }
    
    func setupNavigationBarStyles() {
        self.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
