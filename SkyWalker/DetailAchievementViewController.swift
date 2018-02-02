//
//  DetailAchievementViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/24.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class DetailAchievementViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var GoalField: UITextField!
    @IBOutlet var imageG: UIImageView?
    @IBOutlet var imageB: UIImageView?
    
    
    //reference to the item to display
    //var meitem: MeItem!
    var achievementitemStore = TravelDataItemStore()
    var journerStore: JourneyStore!
    var preGoal : Int?
    //reference to the imageStore
    //number formatter
    let numberFormater: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0
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
        GoalField.delegate = self
        GoalField.backgroundColor = UIColor.whiteColor()
    }
    
    //viewWillAppear() is called right before the view of DetailViewController comes onscreen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        journerStore = JourneyStore()
        print("DetailViewController viewWillAppear.")
        if achievementitemStore.TravelDataItems.goals == nil{
            GoalField.text = "0"
            preGoal = 0
            imageB?.hidden = false
            imageG?.hidden = true
        }
        else {
            preGoal = achievementitemStore.TravelDataItems.goals!
            GoalField.text = numberFormater.stringFromNumber(achievementitemStore.TravelDataItems.goals!)!
            if journerStore.allItems.count >=  achievementitemStore.TravelDataItems.goals!{
                imageB?.hidden = false
                imageG?.hidden = true
            }
            else{
                imageB?.hidden = true
                imageG?.hidden = false
            }
        }
        
        navigationItem.title = "Achievement"
    }
    
    //viewWillDisappear is called right before the view of DetailViewController disappears
    //The function in our case is used to save the values of the three textFields
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(GoalField.text)
        
        //        if let text = nameField.text {
        //            item.name = text
        //        }
        //        else {
        //            item.name = ""
        //        }
        if numberFormater.numberFromString(GoalField.text!) == nil{
            achievementitemStore.TravelDataItems.goals = 0
        }
        else {
            if (Int((numberFormater.numberFromString(GoalField.text!)?.integerValue)!) >= 0){
                achievementitemStore.TravelDataItems.goals = Int((numberFormater.numberFromString(GoalField.text!)?.integerValue)!)
            }
            else{
                achievementitemStore.TravelDataItems.goals = preGoal
            }
        }
        
        
        //achievementitemStore.saveChanges()
        
        
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
        if numberFormater.numberFromString(GoalField.text!) == nil{
            achievementitemStore.TravelDataItems.goals = 0
        }
        else {
            if (Int((numberFormater.numberFromString(GoalField.text!)?.integerValue)!) >= 0){
                achievementitemStore.TravelDataItems.goals = Int((numberFormater.numberFromString(GoalField.text!)?.integerValue)!)
            }
            else{
                achievementitemStore.TravelDataItems.goals = preGoal
            }
        }
        
        if achievementitemStore.TravelDataItems.goals == nil{
            GoalField.text = "0.00"
            imageB?.hidden = false
            imageG?.hidden = true
        }
        else {
            GoalField.text = numberFormater.stringFromNumber(achievementitemStore.TravelDataItems.goals!)!
            if journerStore.allItems.count >=  achievementitemStore.TravelDataItems.goals!{
                imageB?.hidden = false
                imageG?.hidden = true
            }
            else{
                imageB?.hidden = true
                imageG?.hidden = false
            }
        }
    }
    
}


