//
//  DiscoveryItemStore.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import Foundation

class MeItemStore {
    var MeItems : MeItem
        {
        didSet {
            saveChanges()
        }
    }
    
    
    //creates the allItems array from the data saved in the archive
    init() {
        //NSKeyedUnarchiver returns an Anyobject? initialized from data in the archive, which we downcast to [Item] (since the archive actually stores an [Item] object)
        if let archivedItemss = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as! MeItem? {
            MeItems = archivedItemss
        }
        else{
            MeItems = MeItem(random: true)
        }
    }
    
    //itemArchiveURL is the URL of the archive where we will save the allItems array
    let itemArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("Meitems.archive")
    }()
    
    //saveChanges() archives the allItems array to the specified path
    func saveChanges() -> Bool {
        print("Saving allItems to: \(itemArchiveURL.path!)")

        return NSKeyedArchiver.archiveRootObject(MeItems, toFile: itemArchiveURL.path!)
    }
    
    //creates an item, inserts it in the array, and returns the created item
    
    //function to print all items in the array
    func printAllItems() {

        
    }
}
