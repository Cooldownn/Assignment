//
//  AlarmPIC.swift
//  Assignment
//
//  Created by Macintosh on 7/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class AlarmPIC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate
,UITableViewDataSource{
    @IBOutlet weak var changeView: UIBarButtonItem!
    @IBOutlet weak var tableView : UITableView!
    var alarmPIC: AlarmPIC!
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var images :[UIImage]!
    var chooseImage = UIImage()
    var imageView = UIImageView()
    var newImageView = UIImageView()
    var image00 = UIImage(named:"remider_icon")
    var position:Int!
    var imagesDirectoryPath:String!
    var chosenimagesDirectoryPath:String!
    var titles:[String]!
    var imagetemp:[UIImage] = [UIImage(named: "camera")!,UIImage(named: "camera")!,UIImage(named: "camera")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = [UIImage(named:"camera")!]
        titles = ["set"]
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        imagesDirectoryPath = documentDirectorPath + "/ImagePicker1"
        chosenimagesDirectoryPath = documentDirectorPath + "/chosenPIC"
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        let isExist0 = FileManager.default.fileExists(atPath: chosenimagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        else {
            do {
                images.removeAll()
                titles = try FileManager.default.contentsOfDirectory(atPath: imagesDirectoryPath)
                if titles.count > 1 {
                    for image in titles {
                        let data = FileManager.default.contents(atPath: imagesDirectoryPath+"/\(image)")
                        let image = UIImage(data: data!)
                        images.append(image!)
                    }
                    images.append(UIImage(named: "camera")!)
                }
                else {
                    images.append(UIImage(named: "camera")!)
                }
            } catch {
                print ("error")
            }
        }
        if isExist0 == false {
            do{
                try FileManager.default.createDirectory(atPath: chosenimagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func refreshTable(){
        do{
            images.removeAll()
            titles = try FileManager.default.contentsOfDirectory(atPath: imagesDirectoryPath)
            print(titles)
            for image in titles{
                let data = FileManager.default.contents(atPath: imagesDirectoryPath + "/\(image)")
                let image = UIImage(data: data!)
                images.append(image!)
            }
            images.append(UIImage(named: "camera")!)
            self.tableView.reloadData()
        }catch{
            print("Error")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! alarmTableViewCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(takeImage(_:)))
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPressed(_:)))
        cell.image1.image = images[indexPath.item]
        
        
        if indexPath.item == (images.count-1) {
            cell.image1.addGestureRecognizer(tap)
            cell.image1.isUserInteractionEnabled = true
            cell.backgroundColor = UIColor.white
        }
        else if indexPath.item == 0 {
            cell.image1.addGestureRecognizer(longpress)
            cell.image1.isUserInteractionEnabled = true
            cell.backgroundColor = UIColor.orange
        }
        else {
            cell.image1.addGestureRecognizer(longpress)
            cell.image1.isUserInteractionEnabled = true
            cell.backgroundColor = UIColor.orange
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //images[indexPath.item] = UIImage(named: "X")!
        chooseImage = images[indexPath.item]
        //position = indexPath.item
        
    }
    @objc func takeImage(_ sender: UITapGestureRecognizer){
        
        //let index = self.tableView.indexPathForSelectedRow
        
        //self.tableView.selectRow(at: sender.tag, animated: true, scrollPosition: .none)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)}))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)}))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    //    @objc func normaltap(_ sender: UIGestureRecognizer){
    //        if let index = self.tableView.indexPathForSelectedRow{
    //            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: index) as! alarmTableViewCell
    //            cell.backgroundColor = UIColor.gray
    //        }
    //    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: 374  ,height: 206))
        image.draw(in :CGRect(x: 0,y: 0,width: 374,height: 206))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    @objc func imageLongPressed(_ sender: UILongPressGestureRecognizer) {
        imageView = sender.view as! UIImageView
        popupimage(imageView)
    }
    func popupimage(_ sender: UIImageView){
        newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
        sender.view?.removeFromSuperview()
        sender.view?.removeFromSuperview()
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image1 = info[UIImagePickerControllerEditedImage] as! UIImage
        var imagePath = NSDate().description
        imagePath = imagePath.replacingOccurrences(of: " ", with: "")
        imagePath = imagesDirectoryPath+"/\(imagePath).png"
        let data = UIImagePNGRepresentation(image1)
        let success = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        dismiss(animated: true) { () -> Void in
            self.refreshTable()
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Determine what the segue destination is
        if segue.destination is NewPicture
        {
            let vc = segue.destination as? NewPicture
            vc?.imageView0 = chooseImage
            //            vc?.usename = "Set"
            
        }
    }
    
    
}
