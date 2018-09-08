//
//  Alarm.swift
//  Assignment
//
//  Created by Cooldown on 9/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import Foundation
import UIKit

class Alarm: NSObject, NSCoding {
    var notification: UILocalNotification
    var time: NSDate
    var name: String
    // Archive path for Persistent Data
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("alarms")
    
    // enum for property keys
    struct PropertyKeys {
        static let timeKey = "time"
        static let notificationKey = "notification"
        static let nameKey = "name"
    }
    
    // Initializer
    init(time: NSDate,name: String, notification: UILocalNotification)
    {
        self.time = time
        self.notification = notification
        self.name = name
        
        super.init()
    }
    
    // Deconstructor
    deinit {
        // Cancel Notification
        UIApplication.shared.cancelLocalNotification(self.notification)
    }
    
    // NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: PropertyKeys.timeKey)
        aCoder.encode(name, forKey: PropertyKeys.nameKey)
        aCoder.encode(notification, forKey: PropertyKeys.notificationKey)
    }
    
    
    required convenience init(coder aDecoder: NSCoder)
    {
        let time = aDecoder.decodeObject(forKey: PropertyKeys.timeKey) as! NSDate
        let notification = aDecoder.decodeObject(forKey: PropertyKeys.notificationKey) as! UILocalNotification
        let name = aDecoder.decodeObject(forKey: PropertyKeys.nameKey) as! String
        
        self.init(time: time, name: name, notification: notification)
    }
}

