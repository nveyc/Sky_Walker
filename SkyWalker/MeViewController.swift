//
//  MeViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class MeViewController: UITableViewController {
    
    var meitemStore: MeItemStore!
    var travelStore: TravelDataItemStore!
    var journeyStore: JourneyStore!
    var Headers:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if journeyStore == nil{
            journeyStore = JourneyStore();
        }
        //let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        
        //tableView.rowHeight = 150
        tableView.estimatedRowHeight = 65
        //print("Font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        self.Headers=[
            "","  ",""
        ]

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ItemsViewController viewWillAppear")
        
        //reloadData() reloads the cells of the tableView
        tableView.reloadData()
    }
    //Asks the delegate to return a new index path to retarget a proposed move of a ro
    
    //Asks the data source to return the number of sections in the table view.
    //we will have 2 section
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    //Asks the data source to return the number of rows in a given section of a table view.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell1: MeCell!
        var cell2: AchievementCell!
        var cell3: TravelCell!
        var meitem: MeItem!
        if indexPath.section == 0{
            cell1 = tableView.dequeueReusableCellWithIdentifier("MeCell", forIndexPath: indexPath) as! MeCell
            meitem = meitemStore.MeItems
            cell1.name.text = meitem.name
            cell1.email.text = meitem.email
            cell1.photo.image = meitem.photo
            cell1.updateLabels()
            return cell1
        }
        else{
            
            if indexPath.section == 1{
                cell3 = tableView.dequeueReusableCellWithIdentifier("TravelCell", forIndexPath: indexPath) as! TravelCell
                
                cell3.name.text = "Travel Data"
                
                let image = UIImage(named:"travelData.png")
                
                cell3.photo.image = image
                cell3.updateLabels()
                return cell3
            }
            else{
                cell2 = tableView.dequeueReusableCellWithIdentifier("AchievementCell", forIndexPath: indexPath) as! AchievementCell
                cell2.name.text = "Achievement"
                
                let image = UIImage(named:"Achievement.png")
                cell2.photo.image = image
                cell2.updateLabels()
                return cell2
            }
        }
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 100
        }
        else {
            return 40
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 2
        }
        else if section == 1{
            return  1
        }
        else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.Headers![section]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue invoked.")
        
        if segue.identifier == "MeItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = meitemStore
                
                let destinationController = segue.destinationViewController as! DetailMeViewController
                
                //passes a reference of the item to display to the DetailViewController
                destinationController.meitemStore = item
            }
        }
        else if segue.identifier == "AchievementItem" {
            //let itemStore = travelStore
            let item2Store = journeyStore
            let destinationController = segue.destinationViewController as! DetailAchievementViewController
            
            //passes a reference of the item to display to the DetailViewController
            destinationController.achievementitemStore = travelStore
            destinationController.journerStore = item2Store
        }
        else if segue.identifier == "TravelItem" {
            let itemStore = travelStore
            let destinationController = segue.destinationViewController as! DetailTravelDataController
            
            //passes a reference of the item to display to the DetailViewController
            destinationController.travelDataStore = itemStore
        }
    }
    
}
