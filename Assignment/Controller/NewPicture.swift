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
    var imageView0 = UIImage()
    var smallImageViewPlaceholder = UIImageView()
    var largeImageViewPlaceholder = UIImageView()
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var mess : UILabel!
    //
    let movingSearchRectangle = UIView()
    //@IBOutlet weak var TakePic: UIButton
    @IBOutlet weak var Back: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var Upload: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1.image = imageView0
        
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
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func upload(_ sender: Any){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        // vc.sourceType =.
        vc.allowsEditing = true
        vc.delegate = self
        present (vc,animated: true)
    }
    
    @IBAction func fastMatch(sender: AnyObject) {
        if self.checkImagesComparable() == true {
            self.imagePyramid(Image1: imageView1.image!, Image2: imageView.image!)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        imageView.image = image
    }
    func checkImagesComparable() -> Bool {
        
        // exactly equal in both dimensions?
        if  (imageView1.image?.size.height == imageView.image?.size.height) && (imageView1.image?.size.width == imageView.image?.size.width) {
            self.mess.text = "They're equal in size"
            
        }
        return true
    }
    
    func imagePyramid(Image1: UIImage, Image2 : UIImage) {
        let image1 = CIImage(image: Image1)
        let image2 = CIImage(image: Image2)
        var lowestpixelvalue = 255
        let result = self.compareImages(Image1: image1!,Image2:image2!,startingX: 0,startingY: 0)
        if result < lowestpixelvalue {
            lowestpixelvalue = result
        }
        // update the label - it's a UI element, so do this back on the main queue
        OperationQueue.main.addOperation({
            //self.mess.text = "text " + String(result)
            switch lowestpixelvalue {
            case 90...100:
                self.mess.text = "Great match!"
                self.movingSearchRectangle.layer.borderColor = UIColor.green.cgColor
            case 80...90:
                self.mess.text = "Good match"
                self.movingSearchRectangle.layer.borderColor = UIColor.green.cgColor
            case 100...120:
                self.mess.text = "Low confidence here"
                self.movingSearchRectangle.layer.borderColor = UIColor.darkGray.cgColor
            default:
                self.mess.text = "No match found"
                self.movingSearchRectangle.layer.borderColor = UIColor.clear.cgColor
            }
            // turn the button back on
            //self.compareButton.enabled = true
        })
        
        
    }
    
    func compareImages (Image1 : CIImage, Image2 : CIImage, startingX : Int, startingY: Int) -> (Int) {
        
        // we'll use these values several times
        let Image1Width = Image1.extent.width
        let Image1Height = Image1.extent.height
        
        
        // Set up the Core Image FILTER CHAIN
        
        // FILTER 1. To blend the two images
        let differenceFilter = CIFilter(name: "CIDifferenceBlendMode")
        differenceFilter?.setDefaults()
        differenceFilter?.setValue(Image2, forKey: kCIInputBackgroundImageKey)
        // differenceFilter?.setValue(transformFilter?.outputImage, forKey: kCIInputImageKey)
        
        // FILTER 2. To get the average pixel color of the blended image
        let averageFilter = CIFilter(name: "CIAreaAverage")
        averageFilter?.setDefaults()
        averageFilter?.setValue(differenceFilter?.outputImage, forKey: kCIInputImageKey)
        // The blended image will always be the size of the large image, so
        // define a rectangle to just compare the combined section
        // NOTE: I find it's useful to come back in at least one pixel from the edges
        // as sometimes you get a white line at the edge the combined result
        
        let compareRect = CGRect(x: CGFloat(startingX),y: CGFloat(startingY),width: Image1Width-1,height: Image1Height-1)
        let extents = CIVector(cgRect: compareRect)
        
        averageFilter?.setValue(extents, forKey: kCIInputExtentKey)
        //averageFilter?.setValue(differenceFilter?.outputImage, forKey: kCIInputImageKey)
        // that's the filter chain!
        
        // Create the CIContext to draw into
        let space  = CGColorSpaceCreateDeviceRGB()
        let bminfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        var pixelBuffer = Array<CUnsignedChar>(repeating: 255, count: 16)
        let cgCont = CGContext(data: &pixelBuffer, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 16, space: space, bitmapInfo: bminfo.rawValue)
        let contextOptions : [NSObject:AnyObject] = [
            kCIContextWorkingColorSpace as NSObject : space,
            kCIContextUseSoftwareRenderer as NSObject : true as AnyObject,
            ]
        let myContext = CIContext(cgContext: cgCont!, options: contextOptions as? [String : Any])
        
        myContext.draw((averageFilter?.outputImage)!, in: CGRect(x: 0,y: 0,width: Image1Width,height: Image1Height), from: CGRect(x: 0,y: 0,width: Image1Width,height: Image1Height))
        
        let r = Int(pixelBuffer[0])
        let g = Int(pixelBuffer[1])
        let b = Int(pixelBuffer[2])
        // average 'em
        let pixelValue = (r + g + b) / 3
        
        
        
        return (pixelValue)
        
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
