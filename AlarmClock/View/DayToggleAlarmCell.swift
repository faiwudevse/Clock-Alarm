//
//  NextAlarmCell.swift
//  AlarmClock
//
//  Created by Fai Wu on 2/25/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

protocol DayToggleDelegate {
    func didToggle (day : Int, isToggle: Bool)
}


class DayToggleAlarmCell: UITableViewCell, Cell {
    var pickDays: Set<Int>? {
        didSet {
            for day in pickDays! {
                switch day {
                case 0:
                    toggleButton(sender: sundayButton, toggle: true)
                case 1:
                    toggleButton(sender: mondayButton, toggle: true)
                case 2:
                    toggleButton(sender: tuesdayButton, toggle: true)
                case 3:
                    toggleButton(sender: wednesdayButton, toggle: true)
                case 4:
                    toggleButton(sender: thursdayButton, toggle: true)
                case 5:
                    toggleButton(sender: fridayButton, toggle: true)
                case 6:
                    toggleButton(sender: saturdayButton, toggle: true)
                default:
                    print("no match cases")
                }
            }
        }
    }
    
    var delegate: DayToggleDelegate?
    let toggleAttribute : [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor:#colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1)]
    
    let untoggleAttribue : [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
    private let sundayButton: ToggleButton = {
        let button = ToggleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sun", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 0
        return button
    }()
    
    private let mondayButton: ToggleButton = {
        let button = ToggleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToggleDay(_:)), for: .touchUpInside)
        button.setTitle("Mon", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 1
        return button
    }()
    
    private let tuesdayButton: ToggleButton = {
        let button = ToggleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToggleDay(_:)), for: .touchUpInside)
        button.setTitle("Tue", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 2
        return button
    }()
    
    private let wednesdayButton: ToggleButton = {
        let button = ToggleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToggleDay(_:)), for: .touchUpInside)
        button.setTitle("Wed", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 3
        return button
    }()
    
    private let thursdayButton: ToggleButton = {
        let button = ToggleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToggleDay(_:)), for: .touchUpInside)
        button.setTitle("Thur", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 4
        return button
    }()
    
    private let fridayButton: ToggleButton = {
        let button = ToggleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToggleDay(_:)), for: .touchUpInside)
        button.setTitle("Fri", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 5
        return button
    }()
    
    private let saturdayButton: ToggleButton = {
        let button = ToggleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToggleDay(_:)), for: .touchUpInside)
        button.setTitle("Sat", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 6
        return button
    }()
    
    lazy var buttons: [ToggleButton] = [sundayButton, mondayButton,tuesdayButton,wednesdayButton,thursdayButton,fridayButton,saturdayButton]
    lazy var cellStackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 3
        sv.distribution = .fillEqually
        return sv
    }()
    
    @objc private func handleToggleDay(_ sender : ToggleButton) {
        toggleButton(sender: sender)
        delegate?.didToggle(day: sender.tag, isToggle: sender.isToggle)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    private func toggleButton(sender: ToggleButton , toggle: Bool = false) {
        if toggle {
            let attributeString = NSMutableAttributedString(string: sender.titleLabel?.text ?? "", attributes: toggleAttribute)
            sender.setAttributedTitle(attributeString, for: .normal)
        } else {
            sender.isToggle.toggle()
            
            if sender.isToggle {
                let attributeString = NSMutableAttributedString(string: sender.titleLabel?.text ?? "", attributes: toggleAttribute)
                sender.setAttributedTitle(attributeString, for: .normal)
            } else {
                let attributeString = NSMutableAttributedString(string: sender.titleLabel?.text ?? "", attributes: untoggleAttribue)
                sender.setAttributedTitle(attributeString, for: .normal)
            }
            
        }
        
        
    }
    
    fileprivate func setupUI() {
        contentView.addSubview(cellStackView)
        cellStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        for button in buttons {
            button.addTarget(self, action: #selector(handleToggleDay(_:)), for: .touchUpInside)
            let attributeString = NSMutableAttributedString(string: button.titleLabel?.text ?? "", attributes: untoggleAttribue)
            button.setAttributedTitle(attributeString, for: .normal)
        }
        backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
