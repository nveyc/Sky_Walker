//
//  DetailTravelDataViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/24.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//


import UIKit

class DetailTravelDataController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var shoesField: UITextField!
    @IBOutlet var clothesField: UITextField!
    @IBOutlet var hatsField: UITextField!
    //IBOutlet for the UIImageView
    @IBOutlet var shoesImg: UIImageView!
    @IBOutlet var clothesImg: UIImageView!
    @IBOutlet var HatsImg: UIImageView!
    //reference to the item to display
    //var meitem: MeItem!
    var travelDataStore = TravelDataItemStore()
    var flag: Int?
    
    //reference to the imageStore
    
    //number formatter
    let numberFormater: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    //date formatter
    let dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateStyle = .MediumStyle
        df.timeStyle = .NoStyle
        return df
    }()
    
    override func viewDidLoad() {
        print("DetailViewController viewDidLoad")
        shoesField.delegate = self
        clothesField.delegate = self
        hatsField.delegate = self
        shoesImg.userInteractionEnabled = true
        clothesImg.userInteractionEnabled = true
        HatsImg.userInteractionEnabled = true
        let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(DetailTravelDataController.takeShoesPicture(_:)))
        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(DetailTravelDataController.takeClothesPicture(_:)))
        let tapGR3 = UITapGestureRecognizer(target: self, action: #selector(DetailTravelDataController.takeHatsPicture(_:)))
        shoesImg.addGestureRecognizer(tapGR1)
        clothesImg.addGestureRecognizer(tapGR2)
        HatsImg.addGestureRecognizer(tapGR3)
        
        navigationItem.title = "Travel Data"
    }
    
    //viewWillAppear() is called right before the view of DetailViewController comes onscreen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DetailViewController viewWillAppear.")
        
        shoesField.text = travelDataStore.TravelDataItems.shoes
        clothesField.text = travelDataStore.TravelDataItems.clothes
        hatsField.text = travelDataStore.TravelDataItems.hats
        shoesImg.image = travelDataStore.TravelDataItems.shoesImage
        clothesImg.image = travelDataStore.TravelDataItems.clothesImage
        HatsImg.image = travelDataStore.TravelDataItems.hatsImage
        //dateLabel.text = dateFormatter.stringFromDate(meitemStore.MeItems.changeDate) //String(item.dateCreated)
        
        //displays the image associated with the item on imageView
    }
    
    //viewWillDisappear is called right before the view of DetailViewController disappears
    //The function in our case is used to save the values of the three textFields
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("DetailViewController viewWillDisappear.")

        
        travelDataStore.TravelDataItems.shoes = shoesField.text
        travelDataStore.TravelDataItems.clothes = clothesField.text
        travelDataStore.TravelDataItems.hats = hatsField.text
        travelDataStore.TravelDataItems.shoesImage = shoesImg.image
        travelDataStore.TravelDataItems.clothesImage = clothesImg.image
        travelDataStore.TravelDataItems.hatsImage = HatsImg.image
        
        //travelDataStore.saveChanges()
        
        
    }
    
    //textFieldShouldReturn is called when the user taps the keyboard’s return button.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print(#function)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //IBAction for tap gesture recognizer
    @IBAction func backgroundTapped(gestureRecognizer: UITapGestureRecognizer) {
        //print(#function)
        
        view.endEditing(true)
    }
    
    //IBAction for the button on the Toolbar that lets the user select an image
    func takeShoesPicture(sender:UITapGestureRecognizer) {
        print(#function)
        //instantiates the UIImagePickerController
        flag = 1
        let imagePicker = UIImagePickerController()
        
        //sets sourceType of imagePicker
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        //sets DetailViewController as the delegate for imagePicker
        imagePicker.delegate = self
        
        //presents imagePicker modally
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func takeClothesPicture(sender:UITapGestureRecognizer) {
        print(#function)
        //instantiates the UIImagePickerController
        flag = 2
        let imagePicker = UIImagePickerController()
        
        //sets sourceType of imagePicker
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        //sets DetailViewController as the delegate for imagePicker
        imagePicker.delegate = self
        
        //presents imagePicker modally
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    func takeHatsPicture(sender:UITapGestureRecognizer) {
        print(#function)
        //instantiates the UIImagePickerController
        let imagePicker = UIImagePickerController()
        
        flag = 3
        //sets sourceType of imagePicker
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        //sets DetailViewController as the delegate for imagePicker
        imagePicker.delegate = self
        
        //presents imagePicker modally
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func ResizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        let size = image.size
        
        let widthRatio  = width  / image.size.width
        let heightRatio = height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    //Tells the delegate that the user picked a still image or movie.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(#function)
        
        //        for item in info {
        //            print(item)
        //        }
        
        //info is a dictionary that contains information about the media (image) the user selected
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //subscript the dictionary with the appropriate key to get the image selected by the user
        //let t_image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //let image = ResizeImage(t_image, width: 150, height: 150)
        
        
        if flag == 1{
            shoesImg.image = image
            travelDataStore.TravelDataItems.shoesImage = image
        }
        else if flag == 2{
            clothesImg.image = image
            travelDataStore.TravelDataItems.clothesImage = image
        }
        else if flag == 3{
            HatsImg.image = image
            travelDataStore.TravelDataItems.hatsImage = image
        }
        //display the selected image on the imageView (by setting its image property)
        
        
        //store the selected image in the imageStore (which has a cache to store images)
        
        
        //dismiss the view of imagePicker (that was earlier presented modally)
        dismissViewControllerAnimated(true, completion: nil)
    }}


