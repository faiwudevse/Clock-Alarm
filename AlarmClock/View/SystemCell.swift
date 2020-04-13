//
//  VibrationCell.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/27/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit

class SystemCell: UITableViewCell, Cell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
