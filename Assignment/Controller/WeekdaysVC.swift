//
//  WeekdaysVC.swift
//  Assignment
//
//  Created by Cooldown on 10/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class WeekdaysVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var weeksdayTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weeksdayTable.dataSource = self
        weeksdayTable.delegate = self
        
        // Select multiple days
        weeksdayTable.allowsMultipleSelection = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayServices.instance.getWeekdays().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdaysCell") as? WeekdaysCell {
            let weeksday = DayServices.instance.getWeekdays()[indexPath.row]
            cell.updateViews(days: weeksday)
            return cell
        }
        else {
            return WeekdaysCell()
        }
        
    }
    
    
    
    // Func to set checkmark
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.isSelected {
                cell.accessoryType = .checkmark
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    
    
    
    
    
    
    
}
