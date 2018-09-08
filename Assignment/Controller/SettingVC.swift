//
//  SettingVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class SettingVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
 //   var alarmVC: AlarmVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func chooseImg(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)}))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)}))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
      //  alarmVC.chooseImg.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let destinationView = segue.destination as! AlarmVC
    //
    //        destinationView.TransferImage = imageView.image
    //    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
