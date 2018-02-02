//
//  locationItem.swift
//  SkyWalker
//
//  Created by YC, Jiabin on 2017/4/25.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//


import UIKit

class locationItem: NSObject, NSCoding {
    var latitude: Double
    var longtitude: Double
    var name: String?
    let itemKey: String
    
    //designated intializer
    init(latitude: Double, longtitude: Double, name: String) {
        self.latitude = latitude
        self.longtitude = longtitude
        self.name = name
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    //convenience initializer
    convenience init(flag: Bool) {
        self.init(latitude: 0.0, longtitude: 0.0, name: "")
    }
    
    //Archiving: encodeWithCoder() encodes an intance of "Item" inside the NSCoder instance that is passed in the argument
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(latitude, forKey: "latitude")
        aCoder.encodeDouble(longtitude, forKey: "longtitude")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        
    }
    
    //Unarchiving: init() creates an object initialized from data in the NSCoder instance that is passed in the argument
    required init(coder aDecoder: NSCoder) {
        latitude = aDecoder.decodeDoubleForKey("latitude")
        longtitude = aDecoder.decodeDoubleForKey("longtitude")
        name = aDecoder.decodeObjectForKey("name") as? String
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
    }
}


