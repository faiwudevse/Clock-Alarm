//
//  SchedauledNotification.swift
//  AlarmClock
//
//  Created by Fai Wu on 12/9/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import Foundation
import UIKit

class ScheduledNotification {
    private let coreData = (UIApplication.shared.delegate as! AppDelegate).coreData
    private let center = UNUserNotificationCenter.current()
    static let shared = ScheduledNotification()
    
    func addAlarmNotification(alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = alarm.name!
        content.body = "Time to wake up"
        content.categoryIdentifier = alarm.identity!
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: alarm.sound! + ".mp3"))
        
        
        let pickdays = Convenience.shared.convertStrToArr(frequencyStr: alarm.frequency!)
        
        var dateComponents = Convenience.shared.convertTimeStrToDateComponents(time: alarm.time!)

        if pickdays.isEmpty {
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: !pickdays.isEmpty)
            let request = UNNotificationRequest(identifier: alarm.identity! , content: content, trigger: trigger)
            center.add(request)
        } else {
            for day in pickdays {
                dateComponents.weekday = day + 1
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: !pickdays.isEmpty)
                let request = UNNotificationRequest(identifier: alarm.identity! + Constants.DaysOfWeeks.short[day]  , content: content, trigger: trigger)
                center.add(request)
            }
        }
    }
    
    func removeAllPendingAlarmNotification() {
        center.removeAllPendingNotificationRequests()
    }
    
    func getAllPendingAlarmNotification() {
        center.getPendingNotificationRequests { (requests) in
            for request in requests {
                print(request)
            }
        }
    }
    
    func removeDeliveredAlarmNotifications(_ identifier: String) {
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
    }
    
    func updateAllDeliveredNotifications() {
        center.getDeliveredNotifications { (requests) in
            DispatchQueue.main.async(execute: {
                for request in requests {
                    let requestRepeat = request.request.trigger?.repeats ?? false
                    self.removeDeliveredAlarmNotifications(request.request.identifier)
                    if !requestRepeat {
                        let alarm = AlarmObjectFetch.shared.getAnAlarm(name: request.request.identifier)
                        alarm.on = false
                        AlarmObjectFetch.shared.saveAlarmChange()
                    }
                }
            })
        }
    }
    
    func pendingDeliveredNotifications(_ completionHandler: @escaping (_ result: Bool) -> Void) {
        center.getDeliveredNotifications { (requests) in
            let ret = !requests.isEmpty
            completionHandler(ret)
        }
    }
    
    func cancelAlarmToNotification(alarm: Alarm)
    {
        let pickdays = Convenience.shared.convertStrToArr(frequencyStr: alarm.frequency ?? "")
        if pickdays.isEmpty {
            center.removePendingNotificationRequests(withIdentifiers: [alarm.identity!])
        } else {
            for day in pickdays {
                
                center.removePendingNotificationRequests(withIdentifiers: [alarm.identity! + Constants.DaysOfWeeks.short[day]])
            }
        }
    }
}
