//
//  TimePickerAlarmCell.swift
//  AlarmClock
//
//  Created by Fai Wu on 3/12/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import UIKit

protocol TimeSelectedDelegate{
    func didSelectDate(time : String)
}


class TimePickerAlarmCell: UITableViewCell, Cell {
    
    var time: String? {
        didSet {
            timePicker.setDate(Convenience.shared.convertTimeStrToTimeDate(time: time ?? ""), animated: false)
        }
    }
    
    let timePicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .time
        datePicker.setValue(UIColor.black, forKey: "textColor")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    var delegate: TimeSelectedDelegate?
    
    private func setupUI() {
        contentView.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        timePicker.widthAnchor.constraint(equalToConstant: 200).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        timePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        timePicker.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
        backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
    }
    
    @objc private func dateDidChange(_ sender: UIDatePicker) {
        delegate?.didSelectDate(time: Convenience.shared.convertDateIntoStrFormat(date: sender.date))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

