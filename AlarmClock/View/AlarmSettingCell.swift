//
//  AlarmSettingCell.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/20/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit

class AlarmSettingCell: UITableViewCell, Cell {
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let optionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(optionLabel)
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        optionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        optionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
