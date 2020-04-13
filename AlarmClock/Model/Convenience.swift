//
//  Convenience.swift
//  AlarmClock
//
//  Created by Fai Wu on 12/28/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import Foundation

class Convenience {
    static let shared = Convenience()
    
    func convertStrToArr(frequencyStr : String) ->Set<Int> {
        var ret: Set<Int> = []
        
        if frequencyStr == Constants.DaysOfWeeks.weekdays {
            for i in 1...5 {
                ret.insert(i)
            }
        } else if frequencyStr == Constants.DaysOfWeeks.weekends {
            ret.insert(0)
            ret.insert(6)
        } else if frequencyStr == Constants.DaysOfWeeks.everyday {
            for i in 0...6 {
                ret.insert(i)
            }
        } else {
            let strSplit = frequencyStr.split(separator: " ")
            for day in strSplit {
                let ind = Constants.DaysOfWeeks.short.firstIndex(of: String(day)) ?? -1
                if ind != -1 {
                    ret.insert(ind)
                }
            }
        }
        return ret
    }
    
    func createDaysStr(days: [Int]) -> String{
        
        var ret = ""
        
        if days.isEmpty {
            ret = Constants.DaysOfWeeks.once
        }
        else if days.elementsEqual([1,2,3,4,5]) {
            ret = Constants.DaysOfWeeks.weekdays
        }
        else if days.elementsEqual([0,6]) {
            ret = Constants.DaysOfWeeks.weekends
        }
        else if days.elementsEqual([0,1,2,3,4,5,6]) {
            ret = Constants.DaysOfWeeks.everyday
        }
        else {
            for day in days {
                ret += Constants.DaysOfWeeks.short[day] + " "
            }
        }
        return ret
    }
    
    func convertTimeStrToTimeDate(time : String) -> Date {

        let components = convertTimeStrToDateComponents(time : time)
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: components)!
        
        return date
    }
    
    func convertTimeStrToDateComponents(time : String) -> DateComponents {
        var hours = 0
        var minutes = 0
        let timeSubStr = time.split(separator: " ")
        let timeStr = String(timeSubStr[0]).split(separator: ":")
        
        if timeSubStr[1] == "PM" && ((Int(String(timeStr[0])) ?? 0) < 12) {
            hours += 12
        }
        
        hours += Int(String(timeStr[0])) ?? 0
        minutes += Int(String(timeStr[1])) ?? 0
        
        
        var components = DateComponents()
        
        components.hour = hours
        components.minute = minutes
        
        return components
    }
    
    func convertDateIntoStrFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}
