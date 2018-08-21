//
//  AlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class AlarmVC: UIViewController {
    
    var TransferImage: UIImage!
    
    @IBOutlet weak var chooseImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseImg.image = TransferImage
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingsSegue" {
            if let settingVC = segue.destination as? SettingVC {
                settingVC.alarmVC = self
            }
        }
    }
}

