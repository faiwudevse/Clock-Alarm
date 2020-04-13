//
//  DetailAlarmController.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/19/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit

class AlarmSettingViewController : UIViewController{
    
    var alarm: Alarm? {
        didSet {
            alarmName = alarm?.name ?? ""
            alarmSound = alarm?.sound ?? ""
            pickDays = Convenience.shared.convertStrToArr(frequencyStr: alarm?.frequency ?? "")
            dateTime = alarm?.time ?? ""
            selectionTable.reloadData()
        }
    }
    
    private let coreData = (UIApplication.shared.delegate as! AppDelegate).coreData
    
    private let selectionTable = UITableView()
    
    private var pickDays: Set<Int> = []
    private var alarmName = "Alarm"
    private var alarmSound = "Alarm"
    private var dateTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1083748862, green: 0.1081092134, blue: 0.1190437749, alpha: 1)
        
        if alarm != nil {
            navigationItem.title = "Edit Clock"
        } else {
            navigationItem.title = "Add Clock"
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        // register cell
        selectionTable.register(TimePickerAlarmCell.self, forCellReuseIdentifier: TimePickerAlarmCell.defaultReuseIdentifier)
        selectionTable.register(AlarmSettingCell.self, forCellReuseIdentifier: AlarmSettingCell.defaultReuseIdentifier)
        selectionTable.register(DayToggleAlarmCell.self, forCellReuseIdentifier: DayToggleAlarmCell.defaultReuseIdentifier)
        selectionTable.register(AlarmLabelNameCell.self, forCellReuseIdentifier: AlarmLabelNameCell.defaultReuseIdentifier)
        selectionTable.register(AlarmSoundCell.self, forCellReuseIdentifier: AlarmSoundCell.defaultReuseIdentifier)
        
        view.addSubview(selectionTable)

        selectionTable.translatesAutoresizingMaskIntoConstraints = false
        selectionTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        selectionTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectionTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectionTable.heightAnchor.constraint(equalToConstant: 510).isActive = true
        selectionTable.dataSource = self
        selectionTable.delegate = self
        selectionTable.isScrollEnabled = false
        
    }
    
    @objc private func handleCancel() {
        AudioPlayer.shared.stopMusic()
        dismiss(animated: true)
    }
    
    
    @objc private func handleSave() {
        AudioPlayer.shared.stopMusic()
        if self.alarm != nil {
            ScheduledNotification.shared.cancelAlarmToNotification(alarm: self.alarm!)
            self.alarm?.name = alarmName
            self.alarm?.sound = alarmSound
            let days = Convenience.shared.createDaysStr(days: pickDays.sorted())
            self.alarm?.frequency = days

            self.alarm?.time = dateTime
            self.alarm?.on = true
            ScheduledNotification.shared.addAlarmNotification(alarm: self.alarm!)
        }
        else{
            let days = Convenience.shared.createDaysStr(days: pickDays.sorted())

            let identity = alarmName + UUID().uuidString

            let alarm = Alarm(name: alarmName, sound: alarmSound, on: true, identity: identity, vibration: true, frequency: days, time: dateTime ?? "", creationDate: Date(), context: coreData.context)

            ScheduledNotification.shared.addAlarmNotification(alarm: alarm)
        }

        coreData.save()
        
        dismiss(animated: true)
    }
}

extension AlarmSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = HeaderView()
        
        
        if section == 0 {
            headerView.nameLabel.text = "Time"
        } else if section == 1 {
            headerView.nameLabel.text = "Repeat"
        } else if section == 2 {
            headerView.nameLabel.text = "Label"
        } else if section == 3 {
            headerView.nameLabel.text = "Sound"
        }

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = #colorLiteral(red: 0.1083748862, green: 0.1081092134, blue: 0.1190437749, alpha: 1)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TimePickerAlarmCell.defaultReuseIdentifier, for: indexPath) as! TimePickerAlarmCell
            if dateTime != nil {
                cell.time = dateTime
            } else {
                dateTime = Convenience.shared.convertDateIntoStrFormat(date: cell.timePicker.date)
            }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell 
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DayToggleAlarmCell.defaultReuseIdentifier, for: indexPath) as! DayToggleAlarmCell
            cell.pickDays = pickDays
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmLabelNameCell.defaultReuseIdentifier, for: indexPath) as! AlarmLabelNameCell
            cell.delegate = self
            cell.labelNameTextField.text = alarmName
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmSoundCell.defaultReuseIdentifier, for: indexPath) as! AlarmSoundCell
            cell.selectionStyle = .none
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        else if indexPath.section == 3 {
            return 110
        }
        return 50
    }
    
}

extension AlarmSettingViewController : DayToggleDelegate, AlarmLabelNameDelegate, TimeSelectedDelegate, AlarmSoundCellDelegate{
    func didSelectSound(sound: String) {
        alarmSound = sound
    }
    
    func didToggle (day : Int, isToggle: Bool) {
        if isToggle {
            pickDays.insert(day)
        } else {
            pickDays.remove(day)
        }
    }
    
    func didFinishLabelName(name: String) {
        alarmName = name
    }
    
    func didSelectDate(time: String) {
        dateTime = time
    }
}

