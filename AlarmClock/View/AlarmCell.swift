//
//  AlarmCell.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/18/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit


class AlarmCell: UITableViewCell, Cell {
    
    var alarm : Alarm? {
        didSet {
            nameLabel.text = alarm?.name ?? ""
            timeLabel.text = alarm?.time ?? ""
            frequencyLabel.text = alarm?.frequency ?? ""
            onSwitch.isOn = alarm?.on ?? false
            switchBtnOnOfOff(btn: onSwitch.isOn)
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let frequencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let onSwitch: UISwitch = {
        let switchBtn = UISwitch()
        switchBtn.isOn = true
        switchBtn.translatesAutoresizingMaskIntoConstraints = false
        switchBtn.tag = -1
        return switchBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func switchBtnOnOfOff(btn: Bool){
        if btn {
            nameLabel.isEnabled = true
            timeLabel.isEnabled = true
            frequencyLabel.isEnabled = true
        } else {
            nameLabel.isEnabled = false
            timeLabel.isEnabled = false
            frequencyLabel.isEnabled = false
        }
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        contentView.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        contentView.addSubview(onSwitch)
        onSwitch.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        onSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
        contentView.addSubview(frequencyLabel)
        frequencyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        frequencyLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        frequencyLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
