//
//  DetailSpotLightViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class DetailSpotLightViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var name: UITextField!
    @IBOutlet var serialNumber: UITextField!
    @IBOutlet var article: UITextField!
    @IBOutlet var myWebView:UIWebView!
    @IBOutlet var dateLabel: UITextField!
    @IBOutlet var page: UIView!
    //IBOutlet for the UIImageView
    @IBOutlet var imageView: UIImageView!
    
    //reference to the item to display
    var spotLightitem: SpotLightItem!
    
    //reference to the imageStore
    //var spotLightImageStore: SpotLightImageStore!
    
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
        let requestObj = NSURLRequest(URL: spotLightitem.url!);
        myWebView.loadRequest(requestObj);
    }
    
    //viewWillAppear() is called right before the view of DetailViewController comes onscreen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        page.backgroundColor = UIColor(patternImage: spotLightitem.image!)
        print("DetailViewController viewWillAppear.")
        
        name.text = "Location: " + spotLightitem.location
        name.backgroundColor = .clearColor()
        serialNumber.text = "Serial " + spotLightitem.Serialnum!
        serialNumber.backgroundColor = .clearColor()
        article.text = "Title: " + spotLightitem.article!//String(item.valueInDollars)
        article.backgroundColor = .clearColor()
        dateLabel.text = "Date: " + dateFormatter.stringFromDate(spotLightitem.dateCreated) //String(item.dateCreated)
        dateLabel.backgroundColor = .clearColor()
        //displays the image associated with the item on imageView
//        imageView.image = spotLightitem.image
        
        navigationItem.title = spotLightitem.location
    }
    
    //viewWillDisappear is called right before the view of DetailViewController disappears
    //The function in our case is used to save the values of the three textFields
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("DetailViewController viewWillDisappear.")

        
    }
}


























