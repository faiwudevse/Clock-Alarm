//
//  Alarm+CoreDataProperties.swift
//  AlarmClock
//
//  Created by Fai Wu on 12/11/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var frequency: String?
    @NSManaged public var identity: String?
    @NSManaged public var name: String?
    @NSManaged public var on: Bool
    @NSManaged public var sound: String?
    @NSManaged public var time: String?
    @NSManaged public var vibration: Bool

}
