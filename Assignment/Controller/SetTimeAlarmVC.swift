//
//  SetTimeAlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

import AVFoundation

class SetTimeAlarmVC: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {
    
    var alarm: Alarm?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var alarmLbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alarmLbl.delegate = self
        
        // set minimum date/time for picker
        timePicker.minimumDate = NSDate() as Date
        timePicker.locale = NSLocale.current
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func to check if label is empty
    func checkLabel() {
        let text = alarmLbl.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // func to check if date has passed
    func checkDate() {
        if NSDate().earlierDate(timePicker.date) == timePicker.date {
            saveButton.isEnabled = false
        }
    }
    
    // hide keyboard when hit enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkLabel()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        checkDate()
    }
    
    @IBAction func cancelBtn(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let alarmName = alarmLbl.text
            var time = timePicker.date
            let timeInterval = floor(time.timeIntervalSinceReferenceDate/60) * 60
            
            time = NSDate(timeIntervalSinceReferenceDate: timeInterval) as Date
            // build notification
            
            let notification = UILocalNotification()
            notification.alertTitle = "Alarm"
            notification.alertBody = "Ding Dong"
            notification.fireDate = time
            notification.soundName = UILocalNotificationDefaultSoundName
            //player.play()
            
            UIApplication.shared.scheduledLocalNotifications?.append(notification)
            
            alarm = Alarm(time: time as NSDate, name: alarmName!, notification: notification)
            
    }
    
    
    @IBAction func repeatTapped(_ sender: Any) {
        performSegue(withIdentifier: "repeatSegue", sender: self)
    }
    
}
