//
//  AddNewViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit
import MapKit

class AddNewViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate,UIActionSheetDelegate,UITextFieldDelegate{
    
    var rows: Int!
    var journeyStore = JourneyStore()
    var locationitemStore = locationItemStore()
    
    @IBOutlet var placeholderLabel : UILabel?
    @IBOutlet var titletext: UITextField?
    
    @IBOutlet var camera: UIBarButtonItem!
    
    @IBOutlet var temptextView: UITextView?
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var locationName: UIBarButtonItem?
    
    @IBOutlet var locationIcon: UIBarButtonItem?
    
    
    
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
        

        self.temptextView?.becomeFirstResponder()
        locationName!.title = locationitemStore.locationItems.name
        
        let selectedRange = temptextView?.selectedRange
        let newSelectedRange = NSMakeRange(selectedRange!.location+1, 0)
        
        temptextView?.selectedRange = newSelectedRange
    
        
        if temptextView!.text.isEmpty {
            placeholderLabel?.hidden = false
        }
        else{
            placeholderLabel?.hidden = true
        }
        
        self.tabBarController?.tabBar.hidden = true

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titletext?.becomeFirstResponder()
        camera?.enabled = false
        
        if let textView = temptextView
        {
            textView.delegate = self
        }
        titletext!.delegate = self
        
        //temptextView!.addGestureRecognizer(longPressRec)
        temptextView!.userInteractionEnabled = true
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddNewViewController.keyboardWillAppear(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddNewViewController.keyboardWillDisappear(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
        
        if temptextView!.text.isEmpty {
            placeholderLabel?.hidden = false
        }
        else{
            placeholderLabel?.hidden = true
        }
        if rows != nil{
            temptextView?.attributedText = journeyStore.allItems[rows].content
            titletext?.text = journeyStore.allItems[rows].title
            locationName?.title = journeyStore.allItems[rows].title
            if journeyStore.allItems[rows].location != nil {
                locationitemStore.locationItems = journeyStore.allItems[rows].location!
            }
            
        }
        else{
            locationitemStore.locationItems = locationItem(flag: true)
        }

    }
    
    
    
    func keyboardWillAppear(notification: NSNotification) {
        
        let keyboardinfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey]
        let keyboardheight:CGFloat = (keyboardinfo?.CGRectValue.size.height)!
        //tabbarButConstraint?.constant = keyboardheight
        
        //CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
  
        self.bottomConstraint.constant = keyboardheight
        
        // 执行动画
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animateWithDuration(duration, animations: {() -> Void in self.view.layoutIfNeeded()})
        
        print("keyboardWillAppea")
        print(keyboardheight)
        
    }
    
    
    
    func keyboardWillDisappear(notification:NSNotification){
        self.bottomConstraint.constant = 0
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animateWithDuration(duration, animations: {() -> Void in self.view.layoutIfNeeded()})
        print("keyboardWillDisappear")
    }
    
    func longPressedView(){
        print("longpress")
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y < 0 ) {
            view.endEditing(true)
            print( "View scrolled to the bottom" )
            
        }
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing")
        camera?.enabled = true
        locationIcon?.enabled = true
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        print("textViewDidChange")
        if temptextView?.text.isEmpty == false
        {
            placeholderLabel?.hidden = true
        }
        else
        {
            placeholderLabel?.hidden = false
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if textView.text.isEmpty {
            placeholderLabel?.hidden = false
        }
        else{
            placeholderLabel?.hidden = true
        }
        print("textViewDidEndEditing")
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("textFiledShouldBeginEditing")
        camera.enabled = false
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        view.endEditing(true)
        self.tabBarController?.tabBar.hidden = false
   
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        print("333")

        
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
    
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
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
        placeholderLabel!.hidden = true
        return newImage
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(#function)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        if let textView = temptextView
        {
            textView.font = UIFont.systemFontOfSize(16)
            
            let attachment = NSTextAttachment()
            
            let targetSize = CGSize(width: self.view.frame.size.width-10, height: (image.size.height)/(image.size.width) * (self.view.frame.size.width-10))
            
            let tempImage = ResizeImage(image, targetSize: targetSize)
            

            attachment.image = tempImage
            let attStr = NSAttributedString(attachment: attachment)
            let mutableStr = NSMutableAttributedString(attributedString: textView.attributedText)
            let selectedRange = textView.selectedRange
            mutableStr.insertAttributedString(attStr, atIndex: selectedRange.location)
            

            mutableStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(16), range: NSMakeRange(0,mutableStr.length))
            
            let newSelectedRange = NSMakeRange(selectedRange.location+1, 0)
            
            textView.attributedText = mutableStr
           
            textView.selectedRange = newSelectedRange
        }
        
        //dismiss the view of imagePicker (that was earlier presented modally)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    @IBAction func cancleClick(sender: UIBarButtonItem) {
        
        let title = "Quit"
        let message = "Are you sure?"
        
        //UIAlertController
        let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
        //Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        ac.addAction(cancelAction)
        
        //Delete Action
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {(delete) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        ac.addAction(deleteAction)
        
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    @IBAction func doneClick(sender: UIBarButtonItem) {
        
        let tempItem = JourneyItem(name: "test", title: titletext!.text!, content:NSMutableAttributedString(attributedString: temptextView!.attributedText),location: locationitemStore.locationItems)
        
        print(tempItem.content)
        
        journeyStore.createItem(tempItem)
        
        //archives the allItems array when the user presses the "Home" button
        let success = journeyStore.saveChanges()
        
        //prints if the archiving was successful or not
        if success {
            print("Saved all items.")
        }
        else {
            print("Could not save all items.")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func EditDoneClick(sender: UIBarButtonItem) {
        
        let tempItem = JourneyItem(name: "test", title: titletext!.text!, content:NSMutableAttributedString(attributedString: temptextView!.attributedText),location: locationitemStore.locationItems)
        
        print(tempItem.content)
        
        //journeyStore.createItem(tempItem)
        journeyStore.allItems[rows] = tempItem
        //archives the allItems array when the user presses the "Home" button
        let success = journeyStore.saveChanges()
        
        //prints if the archiving was successful or not
        if success {
            print("Saved all items.")
        }
        else {
            print("Could not save all items.")
        }
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue addNew invoked.")
        //var items: [DiscoveryItem]?

            print("111111")
            
        if segue.identifier == "AddNew"
        {
            let destinationController = segue.destinationViewController as? LocationSearchTable
            destinationController!.locationStore = locationitemStore
            
        }
        if segue.identifier == "EditAddNew"
        {
            let destinationController = segue.destinationViewController as! EditLocationSearchTable
            destinationController.locationStore = locationitemStore
        }

        }
    
}
