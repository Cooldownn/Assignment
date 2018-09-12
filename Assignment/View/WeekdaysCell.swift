//
//  WeekdaysCell.swift
//  Assignment
//
//  Created by Cooldown on 10/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class WeekdaysCell: UITableViewCell {
    
    @IBOutlet weak var weeksday: UILabel!
    
    func updateViews(days: Weekdays)
    {
        weeksday.text = days.weekdays
    }
    
}
