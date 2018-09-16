//
//  SetMethodAlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class SetMethodAlarmVC: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var tableView : UITableView!
    var setTimeAlarmVC:SetTimeAlarmVC!
    var method: [UIImage] = [UIImage(named: "camera")!,UIImage(named:"tictactoe-1")!,UIImage(named:"math")!]
    var color: [UIColor] = [UIColor .orange,UIColor .blue,UIColor .green]
    var position: [Int] = [0,1,2]
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "tableViewMethod"
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return method.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! tableViewCellTableViewCell
        //cell.button.setImage(method[indexPath.item], for: .normal)
        cell.backgroundColor = color[indexPath.item]
        cell.label.text = ""
        cell.label.backgroundColor = UIColor(patternImage: resizeImage(image: method[indexPath.item],newWidth: CGFloat(140)))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position1 = position[indexPath.item]
        if position1 == 0 {
            //setTimeAlarmVC.alarmMethod.text = "Compare Picture"
            self.performSegue(withIdentifier: "alarmPIC", sender: self)
        }
        else if position1 == 1 {
           //setTimeAlarmVC.alarmMethod.text = "Tic Tac Toe"
           //self.navigationController?.popViewController(animated: true)
           //performSegue(withIdentifier: "saveDone", sender: self)
           self.dismiss(animated: true, completion: nil)
        }
        else {
            //setTimeAlarmVC.alarmMethod.text = "Math"
           self.dismiss(animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth,height: newWidth))
        image.draw(in :CGRect(x: 0,y: 0,width: newWidth,height: newWidth))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @IBAction func Back(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
        
    }
}
//extension SetMethodAlarmVC: CellDelegate {
//    func changeController(title: String) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "main", bundle:nil)
//        if title == "alarmpic"{
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "alarmpic") as! AlarmPIC
//            self.present(nextViewController, animated:true, completion:nil)
//        }
//        else if title == "mathvc"{
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mathvc") as! MathVC
//            self.present(nextViewController, animated:true, completion:nil)
//        }
//
//    }
//
//}
