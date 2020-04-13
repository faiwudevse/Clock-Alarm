//
//  AlarmFetch.swift
//  AlarmClock
//
//  Created by Fai Wu on 12/27/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AlarmObjectFetch {
    let coreData = (UIApplication.shared.delegate as! AppDelegate).coreData
    static let shared = AlarmObjectFetch()
    
    func getAnAlarm( name : String) -> Alarm {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Query.alarm)
        fr.sortDescriptors = [NSSortDescriptor(key: Constants.Query.createDate, ascending: true)]
        fr.predicate = NSPredicate(format: "identity = %@", argumentArray: [name])
        
        var alarms = [Alarm]()
        
        do {
            alarms = try coreData.context.fetch(fr) as! [Alarm]
        } catch {
            fatalError("unable to fetch")
        }
        
        return alarms.first!
    }
    
    func saveAlarmChange() {
        coreData.save()
    }
}
