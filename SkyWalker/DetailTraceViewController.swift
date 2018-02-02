//
//  AddNewViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit
import MapKit

class DetailJourneyViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate,UIActionSheetDelegate,UITextFieldDelegate{
    
    var journeyItemStore: JourneyStore!
    //var journeyItem: JourneyItem!
    var locationitemStore = locationItemStore()
    var rows: Int!
    var journey: JourneyItem!
    @IBOutlet var textView: UITextView?
    
    
    let longPressRec = UILongPressGestureRecognizer()
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var characterCountLimit:Int?
        characterCountLimit = 33
        let startingLength = textField.text?.characters.count ?? 0
        let lengthToAdd = string.characters.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        return newLength <= characterCountLimit
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        textView?.text = ""
        journeyItemStore = JourneyStore()
        journey = journeyItemStore.allItems[rows]

        
        let mutableStr = NSMutableAttributedString()
        
        
        var jt = journey.title
        jt += "\n\n"
        let title = NSMutableAttributedString(string: jt)
        print(title)
        
        
        print(journey.content)
        mutableStr.insertAttributedString(journey.content, atIndex: 0)
        
        
        print(mutableStr.length)
        title.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(25), range: NSMakeRange(0,title.length))
        
        mutableStr.insertAttributedString(title, atIndex: 0)
        
        textView?.attributedText = mutableStr
    
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {

        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let textView = textView
        {
            textView.delegate = self
        }
        
        print("Font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        self.automaticallyAdjustsScrollViewInsets = false
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue addNew invoked.")
        //var items: [DiscoveryItem]?
        if segue.identifier == "traceEditItem" {
            print("111111")
            
            let destinationController = segue.destinationViewController as! AddNewViewController
            
            
            
            //passes a reference of the item to display to the DetailViewController
            destinationController.rows = rows
            
            
        }
    }
    
}
