//
//  SetTimeAlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class SetTimeAlarmVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseMethodAlarm(_ sender: Any) {
        performSegue(withIdentifier: "methodAlarmVCSegue", sender: self)
    }
    
    @IBAction func cancelBtn (_ sender: AnyObject) {
        self.dismiss(animated: true,completion: nil)
    }
}

