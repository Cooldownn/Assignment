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
    
    var setTimeAlarmVC: SetTimeAlarmVC!
    
    //    var selectedDayArray: [String] = []
    var storedDay: [Int] = []
    
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
                //                selectedDayArray.append(DayServices.instance.getWeekdays()[indexPath.row].weekdays)
                storedDay.append(indexPath.row + 1)
                
                //                print(DayServices.instance.getWeekdays()[indexPath.row].weekdays)
                //                print(selectedDayArray)
                                print(storedDay)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            if let index = storedDay.index(of: indexPath.row) {
                storedDay.remove(at: index + 1)
            }
            //            if let index = selectedDayArray.index(of: DayServices.instance.getWeekdays()[indexPath.row].weekdays) {
            //                selectedDayArray.remove(at: index)
            //                storedDay.remove(at: index)
            //            }
            // print(selectedDayArray)
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        // setTimeAlarmVC.testDaysLabel.text = selectedDayArray.description
        setTimeAlarmVC.repeatDaysLabel.text = repeatText(storedDay: storedDay)
        setTimeAlarmVC.repeatDay = storedDay
        if storedDay.count == 7 {
            setTimeAlarmVC.repeatDaysLabel.text = "Every day"
        }
        else if storedDay.isEmpty {
            setTimeAlarmVC.repeatDaysLabel.text = "Never"
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func repeatText(storedDay: [Int]) -> String {
        var ret = String()
        var weekdaysSorted:[Int] = [Int]()
        
        weekdaysSorted = storedDay.sorted(by: <)
        for day in weekdaysSorted {
            switch day{
            case 1:
                ret += "Sun "
            case 2:
                ret += "Mon "
            case 3:
                ret += "Tue "
            case 4:
                ret += "Wed "
            case 5:
                ret += "Thur "
            case 6:
                ret += "Fri "
            case 7:
                ret += "Sat "
            default:
                break
            }
        }
        return ret
    }
    
    
}
