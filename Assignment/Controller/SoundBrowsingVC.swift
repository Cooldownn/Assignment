
//
//  SoundBrowsingVC.swift
//  Assignment
//
//  Created by Vinh Ngo on 10/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//
import UIKit
import AVFoundation
import Foundation

var soundList = ["Let her go - The Passenger", "Thinking out loud - Ed Sheeran", "Apologize - One Republic"]
var indexOfCell = 0
var player: AVAudioPlayer = AVAudioPlayer()

class SoundBrowsingVC: UITableViewController, AVAudioPlayerDelegate {
<<<<<<< HEAD

=======
>>>>>>> 9095b3279b7bb7729f07ce2dad439b3eb2fdaa53
    var setTimeAlarmVC:SetTimeAlarmVC!
    @IBAction func saveSound(_ sender: Any) {
        setTimeAlarmVC.soundName.text = soundList[indexOfCell]
        //setTimeAlarmVC.soundName.text = "Nothing"
        player.stop()
        performSegue(withIdentifier: "segueOfSound", sender: self)
<<<<<<< HEAD
    
=======
>>>>>>> 9095b3279b7bb7729f07ce2dad439b3eb2fdaa53
    }
    @IBAction func abortSelecting(_ sender: Any) {
        if player.isPlaying{
        player.stop()
        }
        dismiss(animated: true, completion: nil)
        
    }
    /*
     override func viewDidLoad() {
     super.viewDidLoad()
     // Uncomment the following line to preserve selection between presentations
     // self.clearsSelectionOnViewWillAppear = false
     // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     // self.navigationItem.rightBarButtonItem = self.editButtonItem
     }
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     */
    // MARK: - Table view data source
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return soundList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sound", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = soundList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCell = indexPath.row
        for indexCell in 0...soundList.count-1{
            var indexPath1 = NSIndexPath(row: indexCell, section: 0)
            var cell = tableView.cellForRow(at: indexPath1 as IndexPath)
            cell?.accessoryType = .none
            if (indexCell == indexPath.row){
                continue
            }
        }
        do{
            let audioPlayer = Bundle.main.path(forResource: soundList[indexOfCell], ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPlayer!) as URL)
            
        }
        catch {
            //ERROR
        }
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.isSelected{
                cell.accessoryType = .checkmark
            }
        player.play()
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
