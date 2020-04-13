//
//  Constant.swift
//  AlarmClock
//
//  Created by Fai Wu on 12/28/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

struct Constants {
    struct DaysOfWeeks{
        static let full = ["Sunday", "Monday", "Tuesday", "Wendesday", "Thursday", "Friday" , "Saturday"]
        static let short = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        static let sevenDays = 7
        static let title = "Repeat"
        static let every = "Every"
        static let weekdays = "Weekdays"
        static let weekends = "Weekends"
        static let everyday = "Every day"
        static let once = "Once"
    }
    
    struct Sound {
        static let ringtons = ["Alarm", "RailRoadBell", "School", "War", "Evacuation"]
        static let title = "Sound"
    }
    
    struct Navigation {
        static let back = "Back"
    }
    
    struct Query {
        static let createDate = "creationDate"
        static let alarm = "Alarm"
    }
    
    struct Quote {
        static let dream = "Every morning you have two chocies: continue to sleep with your dreams, or wake up and chase them."
    }
    
    struct QuoteOfDay{
        static let url = "https://quotes.rest/qod.json"
    }
    
    struct UserDefaultSetting {
        static let permission = "Permission"
        static let hasLauched = "HasLaunched"
    }
}
