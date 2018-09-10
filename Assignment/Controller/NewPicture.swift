//
//  NewPicture.swift
//  Assignment
//
//  Created by Macintosh on 9/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class NewPicture: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var TakePic: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var Upload: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func takeimg(_ sender : Any){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    @IBAction func upload(_ sender: Any){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
       // vc.sourceType =.
        vc.allowsEditing = true
        vc.delegate = self
        present (vc,animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        imageView.image = image
        // print out the image size as a test
        //print(image.size)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
