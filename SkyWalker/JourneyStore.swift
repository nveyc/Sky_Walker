//
//  JourneyStore.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/22.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//


import UIKit
import Foundation

class JourneyStore {
    var allItems = [JourneyItem]()
    
    //creates the allItems array from the data saved in the archive
    init() {
        //NSKeyedUnarchiver returns an Anyobject? initialized from data in the archive, which we downcast to [Item] (since the archive actually stores an [Item] object)
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as? [JourneyItem] {
            allItems += archivedItems
        }
    }
    
    //itemArchiveURL is the URL of the archive where we will save the allItems array
    let itemArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("jorneyitems.archive")
    }()
    
    //saveChanges() archives the allItems array to the specified path
    func saveChanges() -> Bool {
        print("Saving allItems to: \(itemArchiveURL.path!)")
        
        //archiveRootObject() creates an instance of NSKeyedArchiver (which is a sub-class of NSCoder)
        //and calls encodeWithCoder() on the root object (the allItems array),
        //which RECURSIVELY calls encodeWithCoder() on all of its sub-objects
        //to save all the items inside the same instance of the NSKeyedArchiver
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path!)
    }
    
    
    //creates an item, inserts it in the array, and returns the created item
    func createItem(item: JourneyItem) -> JourneyItem {
        
        allItems.append(item)
        //allItems.insert(item, atIndex: 0)
        
        return item
    }
    
    
    //removes a specified item from the array
    func removeItem(item: JourneyItem) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
            saveChanges()
        }
    }
    
    //reorders an item in the array from "fromIndex" to "toIndex"
    func moveItemFromIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let item = allItems[fromIndex]
        
        allItems.removeAtIndex(fromIndex)
        
        allItems.insert(item, atIndex: toIndex)
    }
    
    //function to print all items in the array
    func printAllItems() {
        for item in allItems {
            print("Name: \(item.name) Value: \(item.title) Date: \(item.dateCreated)")
        }
    }
}







