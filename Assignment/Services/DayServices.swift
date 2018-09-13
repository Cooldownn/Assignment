//
//  DayServices.swift
//  Assignment
//
//  Created by Cooldown on 10/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import Foundation
class DayServices {
    static let instance = DayServices()
    
    private let weekdays = [
        Weekdays(weekdays: "Every Sunday"),
        Weekdays(weekdays: "Every Monday"),
        Weekdays(weekdays: "Every Tuesday"),
        Weekdays(weekdays: "Every Wednesday"),
        Weekdays(weekdays: "Every Thursday"),
        Weekdays(weekdays: "Every Friday"),
        Weekdays(weekdays: "Every Saturday")
    ]
    
    func getWeekdays() -> [Weekdays] {
        return weekdays
    }
    
}
