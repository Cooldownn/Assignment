//
//  AlarmPIC.swift
//  Assignment
//
//  Created by Macintosh on 7/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class AlarmPIC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    //  @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var alarmPIC: AlarmPIC!
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
//    var collectionView : UICollectionView!
    var images = [UIImage]()
    var chooseImage = UIImage()
    var image00 = UIImage(named:"remider_icon")
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.addSubview(collectionView!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseImg(_ sender: Any) {
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
     func numberOfSections(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for: indexPath)
            as! imageUICollectionViewCell
        cell.image1.image = self.images[indexPath.item]
        
        
        return cell
    }
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        //let label = UILabel("button")
        let newImageView = UIImageView(image: imageView.image)
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
//        self.navigationController?.isNavigationBarHidden = false
//        self.tabBarController?.tabBar.isHidden = false
//        sender.view?.removeFromSuperview()
        let alert = UIAlertController(title: "Choose Image", message: "Use this image as default", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes",style: .default, handler: { (action: UIAlertAction) in
            let chooseImageView = sender.view as! UIImageView
            self.chooseImage = chooseImageView.image!
            self.navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = false
            sender.view?.removeFromSuperview()}))
        alert.addAction(UIAlertAction(title: "No",style: .default, handler: { (action: UIAlertAction) in
            sender.view?.removeFromSuperview()}))
        self.present(alert, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image1 = info[UIImagePickerControllerEditedImage] as! UIImage
        images.insert(image1,at:0)
        collectionView.reloadData()
        picker.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true,completion: nil)
        collectionView.reloadData()

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
