//
//  DiscoveryViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class DiscoverySelectionViewController: UITableViewController {
    //reference to ItemStore
    var discoveryItems: [DiscoveryItem]! //= ItemStore()

    
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
        super.viewDidLoad()
        //set contentInset for tableView
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        
        //tableView.rowHeight = 150
        tableView.estimatedRowHeight = 65
        
        print("Font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        
        //navigationItem is a property for configuring the UINavigationBar (it is NOT a view object)
        navigationItem.title = discoveryItems![0].catagory
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ItemsViewController viewWillAppear")
        
        //reloadData() reloads the cells of the tableView
        tableView.reloadData()
    }

    
    //Asks the data source to return the number of sections in the table view.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("\(#function) 1")
        return 1
    }
    
    //Asks the data source to return the number of rows in a given section of a table view.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveryItems.count
    }
    
    //Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath: S: \(indexPath.section) R: \(indexPath.row)")
        
        let item = discoveryItems[indexPath.row]

        
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscoverySelectionCell", forIndexPath: indexPath) as! DiscoverySelectionCell
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars!)"
        cell.images.image = item.image!
        cell.updateLabels()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    //When a segue is triggered, the prepareForSegue(_:sender:) method is called on the view controller initiating the segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue invoked.")
        
        if segue.identifier == "DiscoveryShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = discoveryItems[row]
                
                let destinationController = segue.destinationViewController as! DetailDiscoverViewController
                
                //passes a reference of the item to display to the DetailViewController
                destinationController.discoveryitem = item
                
            }
        }
     }
}
