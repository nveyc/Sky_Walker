//
//  JourneyItem.swift
//  SkyWalker
//
//  Created by YC on 2017/4/22.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class JourneyItem: NSObject, NSCoding {
    var name: String
    var title: String
    var content: NSMutableAttributedString
    var location: locationItem?
    let dateCreated: NSDate
    let itemKey: String
    
    //designated intializer
    init(name: String, title: String, content: NSMutableAttributedString, location: locationItem) {
        self.name = name
        self.title = title
        self.content = content
        self.dateCreated = NSDate()
        self.location = location
        self.itemKey = NSUUID().UUIDString
        super.init()
    }
    
    
    //Archiving: encodeWithCoder() encodes an intance of "Item" inside the NSCoder instance that is passed in the argument
    func encodeWithCoder(aCoder: NSCoder) {
        print("encodeWithCoder: \(name)")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(content, forKey: "content")
        aCoder.encodeObject(location, forKey: "location")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
    }
    
    //Unarchiving: init() creates an object initialized from data in the NSCoder instance that is passed in the argument
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        title = aDecoder.decodeObjectForKey("title") as! String
        content = aDecoder.decodeObjectForKey("content") as! NSMutableAttributedString
        location = aDecoder.decodeObjectForKey("location")as? locationItem
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
    }
}
