//
//  AlarmTableViewController.swift
//  AlarmClock
//
//  Created by Fai Wu on 11/18/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import UIKit
import CoreData
class AlarmTableViewController: UITableViewController {
    
    private let coreData = (UIApplication.shared.delegate as! AppDelegate).coreData
    private var fetchedResultsController:NSFetchedResultsController<Alarm>!
    
    override func viewDidLoad() {
        loadAlarms()
        super.viewDidLoad()
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.defaultReuseIdentifier)
        setupUI()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        let permission = defaults.bool(forKey: Constants.UserDefaultSetting.permission)
        let hasLaunched = defaults.bool(forKey: Constants.UserDefaultSetting.hasLauched)
        if self.tableView.window != nil {
            
        }
        if !permission &&  hasLaunched{
            let notificationPermissionVC = NotificationPermissionViewController()
            notificationPermissionVC.modalPresentationStyle = .fullScreen
            present(notificationPermissionVC, animated: true)
        } else {
            defaults.set(true, forKey: Constants.UserDefaultSetting.hasLauched)
        }
    }
    
    private func loadAlarms() {
        let fetchRequest:NSFetchRequest<Alarm> = Alarm.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: Constants.Query.createDate, ascending: false)
         fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreData.context, sectionNameKeyPath: nil, cacheName: Constants.Query.alarm)
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    private func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "baseline_info_white"), style: .plain, target: self, action: #selector(handleGoToAcknowledgement))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "baseline_alarm_add_white"), style: .plain, target: self, action: #selector(handleAddAlarms))
        navigationItem.title = "Alarm Clock"
    }
    
    @objc func handleGoToAcknowledgement() {
        let acknowledgementVC = AcknowledgementViewController()
        let vc = CustomNaviController(rootViewController: acknowledgementVC)
        present(vc, animated: true)
    }
    
    @objc func handleAddAlarms() {
        let alarmSettingVC = AlarmSettingViewController()
        let vc = CustomNaviController(rootViewController: alarmSettingVC)

        present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let alarm = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.defaultReuseIdentifier, for: indexPath) as! AlarmCell
        cell.alarm = alarm
        cell.onSwitch.tag = indexPath.row
        cell.onSwitch.addTarget(self, action: #selector(handleAlarmSwitch(_:)), for: .valueChanged)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alarm = fetchedResultsController.object(at: indexPath)
        let detailAlarmController = AlarmSettingViewController()
        detailAlarmController.alarm = alarm
        
        let vc = CustomNaviController(rootViewController: detailAlarmController)
        present(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHanlder) in
            self.deleteAlarm(at: indexPath)
            completionHanlder(true)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    private func deleteAlarm(at indexPath: IndexPath) {
        let alarm = fetchedResultsController.object(at: indexPath)
        ScheduledNotification.shared.cancelAlarmToNotification(alarm: alarm)
        coreData.context.delete(alarm)
        coreData.save()
    }
    
    @objc private func handleAlarmSwitch(_ sender : UISwitch) {
        
        let index = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: index) as! AlarmCell
        cell.switchBtnOnOfOff(btn: sender.isOn)
        let anAlarm = fetchedResultsController.object(at: index)
        anAlarm.on = sender.isOn
        coreData.save()
        
        if sender.isOn {
            ScheduledNotification.shared.addAlarmNotification(alarm: anAlarm)
        } else {
            ScheduledNotification.shared.cancelAlarmToNotification(alarm: anAlarm)
        }
    }
    
    // the height for each row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension AlarmTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .none)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert: tableView.insertSections(indexSet, with: .fade)
        case .delete: tableView.deleteSections(indexSet, with: .fade)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        }
    }

    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
