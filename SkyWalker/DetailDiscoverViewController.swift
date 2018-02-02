//
//  DetailDiscoverViewController.swift
//  SkyWalker
//
//  Created by Jiabin on 2017/4/20.
//  Copyright © 2017年 JiabinJiabinSyracuse University. All rights reserved.
//

import UIKit

class DetailDiscoverViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    
    //IBOutlet for the UIImageView
    @IBOutlet var imageView: UIImageView!
    
    //reference to the item to display
    var discoveryitem: DiscoveryItem!
    
    //reference to the imageStore
    var discoveryImageStore: DiscoveryImageStore!
    
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
        serialNumberField.delegate = self
        valueField.delegate = self
    }
    
    //viewWillAppear() is called right before the view of DetailViewController comes onscreen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DetailViewController viewWillAppear.")
        
        nameField.text = discoveryitem.name
        serialNumberField.text = discoveryitem.serialNumber
        valueField.text = numberFormater.stringFromNumber(discoveryitem.valueInDollars) //String(item.valueInDollars)
        dateLabel.text = dateFormatter.stringFromDate(discoveryitem.dateCreated) //String(item.dateCreated)
        
        //displays the image associated with the item on imageView
        imageView.image = discoveryImageStore.imageForKey(discoveryitem.itemKey)
        
        navigationItem.title = discoveryitem.name
    }
    
    //viewWillDisappear is called right before the view of DetailViewController disappears
    //The function in our case is used to save the values of the three textFields
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("DetailViewController viewWillDisappear.")
        
        //        if let text = nameField.text {
        //            item.name = text
        //        }
        //        else {
        //            item.name = ""
        //        }
        
        discoveryitem.name = nameField.text ?? ""
        
        discoveryitem.serialNumber = serialNumberField.text
        
        if let text = valueField.text, value = numberFormater.numberFromString(text) {
            discoveryitem.valueInDollars = value.integerValue
        }
        else {
            discoveryitem.valueInDollars = 0
        }
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
    @IBAction func takePicture(button: UIBarButtonItem) {
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
    
    //Tells the delegate that the user picked a still image or movie.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(#function)
        
        //        for item in info {
        //            print(item)
        //        }
        
        //info is a dictionary that contains information about the media (image) the user selected
        //subscript the dictionary with the appropriate key to get the image selected by the user
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //display the selected image on the imageView (by setting its image property)
        imageView.image = image
        
        //store the selected image in the imageStore (which has a cache to store images)
        discoveryImageStore.setImage(image, forKey: discoveryitem.itemKey)
        
        //dismiss the view of imagePicker (that was earlier presented modally)
        dismissViewControllerAnimated(true, completion: nil)
    }}
