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

    let movingSearchRectangle = UIView()
    //@IBOutlet weak var TakePic: UIButton
    @IBOutlet weak var Back: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var Upload: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     //   imageView1.image = imageView0
   
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
    @IBAction func compareCheck(_ sender: Any){
        checkImagesComparable()
    }
    @IBAction func fastMatch(sender: AnyObject) {
        
        // stop the controls from being used
        
        if self.checkImagesComparable() == true {
            // execute on background thread, so it doesn't block
            var backgroundQueue = OperationQueue()
            backgroundQueue.addOperation({
                
                self.createSearchRectangle(smallImageView: self.smallImageViewPlaceholder, largeImageView: self.largeImageViewPlaceholder)
                self.imagePyramid(smallImage: self.smallImageViewPlaceholder.image!, largeImage: self.largeImageViewPlaceholder.image!)
                
            })
        }
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
    func checkImagesComparable() -> Bool {
        
        // exactly equal in both dimensions?
        if  (imageView1.image?.size.height == imageView.image?.size.height) && (imageView1.image?.size.width == imageView.image?.size.width) {
            self.mess.text = "They're equal in size"
            return false
        }
        
        // smaller in one dimension, but larger in another? cannot be a subset.
        if (CGFloat((imageView1.image?.size.height)!) < CGFloat((imageView.image?.size.height)!)  && CGFloat((imageView1.image?.size.width)!) > CGFloat((imageView.image?.size.width)!)) || (CGFloat((imageView1.image?.size.height)!) > CGFloat((imageView.image?.size.height)!)  && CGFloat((imageView1.image?.size.width)!) < CGFloat((imageView.image?.size.width)!)) {
            self.mess.text = "Subset not possible"
            return false
        }
        
        // What we need is an image that is smaller in at least one dimension, and at most equal in the other
        if  (CGFloat((imageView1.image?.size.height)!) < CGFloat((imageView.image?.size.height)!)) && (CGFloat((imageView1.image?.size.width)!) <= CGFloat((imageView.image?.size.width)!)) || (CGFloat((imageView1.image?.size.width)!) < CGFloat((imageView.image?.size.width)!)) && (CGFloat((imageView1.image?.size.height)!) <= CGFloat((imageView.image?.size.height)!)) {
            // 1 image is smaller
            smallImageViewPlaceholder = imageView1
            largeImageViewPlaceholder = imageView
            self.mess.text = " Not equal"
        } else {
            //  image is smaller
            smallImageViewPlaceholder = imageView
            largeImageViewPlaceholder = imageView1
            self.mess.text = " Not equal"
        }
        return true
    }
    // Create the UI "search rectangle" that moves over the larger image
    func createSearchRectangle(smallImageView: UIImageView, largeImageView : UIImageView) {
        
        // We must use the size of the image, not the size of the ImageView control.
        
        // determine scale of largest image
        
        let widthScale = largeImageView.bounds.size.width / largeImageView.image!.size.width
        let heightScale = largeImageView.bounds.size.height / largeImageView.image!.size.height
        
        // we want its smallest measurement, as we are scaling in proportion
        let minimumScale = widthScale < heightScale ? widthScale : heightScale
        var scaledHeight = largeImageView.image!.size.height * minimumScale
        
        var y = Int(round( (largeImageView.bounds.size.height - (scaledHeight)) / 2.0))
        
        var boxWidth = Int(smallImageView.image!.size.width * minimumScale)
        var boxHeight = Int(smallImageView.image!.size.height * minimumScale)
        
        // Any change to UI elements should be done on the main queue
        OperationQueue.main.addOperation({
            self.movingSearchRectangle.frame = CGRect(x: 0, y: y, width: boxWidth, height: boxHeight)
            
            
            self.movingSearchRectangle.layer.borderWidth = 5.0
            self.movingSearchRectangle.layer.borderColor = UIColor.gray.cgColor
            
            largeImageView.addSubview(self.movingSearchRectangle)
        })
    }
    func imagePyramid(smallImage: UIImage, largeImage : UIImage) {
        
        // how big is the small image? count the pixels
        let checkSize = smallImage.size.height * smallImage.size.width
        
        // default scale to ten percent
        var scaleFactor : Float = 0.1
        
        // the bigger the image is, the more we begin by scaling it down
        switch checkSize {
        case 0...100:
            print("It's tiny - no scaling")
            scaleFactor = 1
        case 101...500:
            print("not very big")
            scaleFactor = 0.8
        case 501...1000:
            print("still small")
            scaleFactor = 0.6
        case 1001...4000:
            print("over 1000 pixels")
            scaleFactor = 0.5
        case 4001...10000:
            print("over 4000 pixels")
            scaleFactor = 0.4
        case 10001...20000:
            print("over 10000 pixels")
            scaleFactor = 0.3
        case 20001...40000:
            print("over 20000 pixels")
            scaleFactor = 0.2
        case 40001...60000:
            print("over 40000 pixels")
            scaleFactor = 0.1
        case 60001...90000:
            print("over 60000 pixels")
            scaleFactor = 0.09
        case 90001...120000:
            print("over 90000 pixels")
            scaleFactor = 0.08
        case 120001...150000:
            print("over 120000 pixels")
            scaleFactor = 0.07
        case 150001...200000:
            print("over 150000 pixels")
            scaleFactor = 0.06
        case 200001...250000:
            print("over 200000 pixels")
            scaleFactor = 0.05
        case 250001...300000:
            print("over 250000 pixels")
            scaleFactor = 0.04
        default:
            print("how big is this thing?")
            scaleFactor = 0.03
        }
        
        var initialX = 0
        var initialY = 0
        
        var lowestPixelValue = 255
        
        // how many passes do we want to make?
        for i in 1...4 {
            // resize the NSImage
            let newImageL = resize(sourceImage: largeImage, scaleFactor: scaleFactor)
            let newImageS = resize(sourceImage: smallImage, scaleFactor: scaleFactor)
            // make CIImage from resized NSImage
            let resizedSmallImage = CIImage(image: newImageS)
            let resizedLargeImage = CIImage(image: newImageL)
            
            let result = self.compareImages(smallImage: resizedSmallImage!, largeImage: resizedLargeImage!, startingX: initialX, startingY: initialY)
            
            print("Pass \(i) - low value of \(result.0) at x:\(result.1) y:\(result.2) ")
            
            if result.0 < lowestPixelValue {
                lowestPixelValue = result.0
            }
            
            initialX = (result.1 * 2)
            initialY = (result.2 * 2)
            
            // double the scale factor for the next time around
            scaleFactor *= 2
            
            // if there's not even a near match, might as well stop
            // if we're already at 1:1 scale, stop.
            if lowestPixelValue > 50 || scaleFactor > 1 {
                break
            }
        }
        
        // update the label - it's a UI element, so do this back on the main queue
        OperationQueue.main.addOperation({
            
            switch lowestPixelValue {
            case 0...15:
                self.mess.text = "Great match!"
                self.movingSearchRectangle.layer.borderColor = UIColor.green.cgColor
            case 16...25:
                self.mess.text = "Good match"
                self.movingSearchRectangle.layer.borderColor = UIColor.green.cgColor
            case 26...35:
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
    func resize(sourceImage : UIImage, scaleFactor: Float) -> UIImage {
        
        var oldSize =  sourceImage.size
        var tempsource:UIImage = sourceImage
        let newSize = sourceImage.size.applying(CGAffineTransform(scaleX: CGFloat(scaleFactor), y: CGFloat(scaleFactor)))
        //var imageV = UIImageView(size: newSize)
        var smallImage = UIImage()
        UIGraphicsBeginImageContextWithOptions(newSize, true, CGFloat(scaleFactor))
        smallImage.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
    
        //reset original image
       // sourceImage = tempsource
        
        return smallImage
    }
    func calcSearchRectanglePosition(fullWidth:Float, fullHeight: Float, xPos: Float, yPos: Float) -> (Int, Int, Int, Int) {
        
        // how far along within the boundaries of the image are we?
        let percentX  = xPos / fullWidth
        let percentY  = yPos / fullHeight
        
        // determine scale of displayed image
        let widthScale = largeImageViewPlaceholder.bounds.size.width / largeImageViewPlaceholder.image!.size.width
        let heightScale = largeImageViewPlaceholder.bounds.size.height / largeImageViewPlaceholder.image!.size.height
        
        // we want the smallest one, as we are scaling in proportion
        let minimumScale = widthScale < heightScale ? widthScale : heightScale
        
        var scaledHeight = largeImageViewPlaceholder.image!.size.height * minimumScale
        var scaledWidth = largeImageViewPlaceholder.image!.size.width * minimumScale
        
        var newX = Float(scaledWidth) * percentX
        var newY = Float(scaledHeight) * percentY
        
        // get extra pixels for padding between the image and the image view control
        var extraY = (largeImageViewPlaceholder.bounds.size.height - scaledHeight) / 2.0
        var extraX = (largeImageViewPlaceholder.bounds.size.width - scaledWidth) / 2.0
        
        newX = newX + Float(extraX)
        newY = newY + Float(extraY)
        
        var boxWidth = Int(round(smallImageViewPlaceholder.image!.size.width * minimumScale))
        var boxHeight = Int(round(smallImageViewPlaceholder.image!.size.height * minimumScale))
        
        return(Int(round(newX)),Int(round(newY)),boxWidth,boxHeight)
    }
    func compareImages (smallImage : CIImage, largeImage : CIImage, startingX : Int, startingY: Int) -> (Int, Int, Int) {
        
        // we'll use these values several times
        let smallImageWidth = smallImage.extent.width
        let smallImageHeight = smallImage.extent.height
        let largeImageWidth = largeImage.extent.width
        let largeImageHeight = largeImage.extent.height
        
        // Set up the Core Image FILTER CHAIN
        
        // FILTER 1. To move the position of the small image
        let transformFilter = CIFilter(name: "CIAffineTransform")
        transformFilter?.setDefaults()
        // define the input image to the filter
        transformFilter?.setValue(smallImage, forKey: kCIInputImageKey)
        // initial position?
        let affineTransform = CGAffineTransform()
        affineTransform.translatedBy(x: CGFloat(startingX), y: CGFloat(startingY))
        transformFilter?.setValue(affineTransform, forKey: kCIInputTransformKey)
        
        // FILTER 2. To blend the two images
        let differenceFilter = CIFilter(name: "CIDifferenceBlendMode")
        differenceFilter?.setDefaults()
        differenceFilter?.setValue(largeImage, forKey: kCIInputBackgroundImageKey)
        differenceFilter?.setValue(transformFilter?.outputImage, forKey: kCIInputImageKey)
        
        // FILTER 3. To get the average pixel color of the blended image
        let averageFilter = CIFilter(name: "CIAreaAverage")
        averageFilter?.setDefaults()
        averageFilter?.setValue(differenceFilter?.outputImage, forKey: kCIInputImageKey)
        // The blended image will always be the size of the large image, so
        // define a rectangle to just compare the combined section
        // NOTE: I find it's useful to come back in at least one pixel from the edges
        // as sometimes you get a white line at the edge the combined result
        
        let compareRect = CGRect(x: CGFloat(startingX),y: CGFloat(startingY),width: smallImageWidth-1,height: smallImageHeight-1)
        let extents = CIVector(cgRect: compareRect)
        
        averageFilter?.setValue(extents, forKey: kCIInputExtentKey)
        
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
        //let myContext = CIContext(cgContext: <#T##CGContext#>, options: <#T##[String : Any]?#>)
        
        // how far along the x and y axis of the large image do we need to look?
        var maximumX : Int = Int(largeImageWidth) - Int(smallImageWidth)
        var maximumY : Int = Int(largeImageHeight) - Int(smallImageHeight)
        
        // unless! if we've passed in a specific area to begin searching, we only want to look around that area -
        // say, within a few pixels of the current image size
        if startingX != 0 && startingY != 0 {
            if maximumX > startingX + 10 {
                maximumX = startingX + 10
            }
            if maximumY > startingY + 10 {
                maximumY = startingY + 10
            }
        }
        
        // set up variables to hold the lowest pixel position
        var lowestPixelValue = 256
        var lowestPixelXPosition = -1
        var lowestPixelYPosition = -1
        
        for yPosition in startingY..<maximumY {
            for xPosition in startingX..<maximumX {
                
                // reset the blend input to make sure we're always using the output of the most recent transform
                differenceFilter?.setValue(transformFilter?.outputImage, forKey: kCIInputImageKey)
                
                // restrict the area of the blended image we're looking at
                let compareRect = CGRect(x: CGFloat(xPosition),y: CGFloat(yPosition), width: smallImageWidth-1, height: smallImageHeight-1)
                //let extents = init(cgRect: compareRect)
                let extents = CIVector(cgRect: compareRect)
                averageFilter?.setValue(extents, forKey: kCIInputExtentKey)
                averageFilter?.setValue(differenceFilter?.outputImage, forKey: kCIInputImageKey)
                
                // render that final single pixel result
                myContext.draw((averageFilter?.outputImage)!, in: CGRect(x: 0,y: 0,width: 1,height: 1), from: CGRect(x: 0,y: 0,width: 1,height: 1))
                
                let r = Int(pixelBuffer[0])
                let g = Int(pixelBuffer[1])
                let b = Int(pixelBuffer[2])
                // average 'em
                var pixelValue = (r + g + b) / 3
                
                // is this the lowest pixel we've seen?
                if pixelValue < lowestPixelValue {
                    lowestPixelValue = pixelValue
                    lowestPixelXPosition = xPosition
                    lowestPixelYPosition = yPosition
                }
                
                // we don't need to update the rectangle position _every_ time
                if xPosition % 10 == 0 {
                    
                    var newPosition = self.calcSearchRectanglePosition(fullWidth: Float(largeImageWidth), fullHeight: Float(largeImageHeight), xPos: Float(xPosition), yPos: Float(yPosition))
                    
                    OperationQueue.main.addOperation( {
                        // change position
                        self.movingSearchRectangle.frame = CGRect(x: newPosition.0, y: newPosition.1, width: newPosition.2, height: newPosition.3)
                    })
                }
                // move the transform one pixel to the right
                affineTransform.translatedBy(x : 1, y : 0)
                
            
            }
            // after each movement along the X axis, move back to the start of X
            // and up one on the Y axis
            affineTransform.translatedBy(x: -CGFloat(maximumX-startingX), y: 1 )
        }
        
        return (lowestPixelValue, lowestPixelXPosition, lowestPixelYPosition)
        
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
