//
//  DetailMeViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/22.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class DetailMeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    
    //IBOutlet for the UIImageView
    @IBOutlet var imageView: UIImageView!
    
    
    
    //reference to the item to display
    //var meitem: MeItem!
    var meitemStore = MeItemStore()
    
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
        nameField.delegate = self
        emailField.delegate = self
    }
    
    //viewWillAppear() is called right before the view of DetailViewController comes onscreen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DetailViewController viewWillAppear.")
        
        nameField.text = meitemStore.MeItems.name
        emailField.text = meitemStore.MeItems.email
        //dateLabel.text = dateFormatter.stringFromDate(meitemStore.MeItems.changeDate) //String(item.dateCreated)
        
        //displays the image associated with the item on imageView
        imageView.image = meitemStore.MeItems.photo
        
        navigationItem.title = meitemStore.MeItems.name
    }
    
    //viewWillDisappear is called right before the view of DetailViewController disappears
    //The function in our case is used to save the values of the three textFields
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("DetailViewController viewWillDisappear.")

        
        meitemStore.MeItems.name = nameField.text!
        meitemStore.MeItems.email = emailField.text!
        meitemStore.MeItems.photo = imageView.image
        
        //meitemStore.saveChanges()
        
        
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
    @IBAction func takePicture(button: UIButton) {
        print(#function)
        //instantiates the UIImagePickerController
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

        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage

        
        
        
        //display the selected image on the imageView (by setting its image property)
        imageView.image = image
        
        //store the selected image in the imageStore (which has a cache to store images)
        meitemStore.MeItems.photo = image
        
        //dismiss the view of imagePicker (that was earlier presented modally)
        dismissViewControllerAnimated(true, completion: nil)
    }}

