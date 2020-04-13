//
//  Alarm+CoreDataClass.swift
//  AlarmClock
//
//  Created by Fai Wu on 12/11/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


public class Alarm: NSManagedObject {
    convenience init(name: String, sound: String, on: Bool, identity: String, vibration: Bool, frequency: String, time: String, creationDate: Date, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Alarm", in: context){
            self.init(entity: ent, insertInto: context)
            self.name = name
            self.sound = sound
            self.on = on
            self.identity = identity
            self.vibration = vibration
            self.frequency = frequency
            self.time = time
            self.creationDate = creationDate
         }else{
             fatalError("Unable to find Entity name!")
         }
    }
}
