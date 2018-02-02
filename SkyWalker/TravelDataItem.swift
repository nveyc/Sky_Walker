//
//  TravelDataItem.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/24.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//


import UIKit

class TravelDataItem: NSObject, NSCoding {
    var shoes: String?
    var shoesImage: UIImage?
    var clothes: String?
    var clothesImage: UIImage?
    var hats: String?
    var hatsImage: UIImage?
    var goals: Int?
    var changeDate: NSDate
    //var image: UIImage?
    let itemKey: String
    
    //designated intializer
    init(shoes: String?,shoesImage: UIImage?, clothes: String?, clothesImage: UIImage?, hats: String?, hatsImage: UIImage?, goals: Int?) {
        self.shoes = shoes
        self.shoesImage = shoesImage
        self.clothes = clothes
        self.clothesImage = clothesImage
        self.hats = hats
        self.hatsImage = hatsImage
        self.goals = goals
        self.changeDate = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    //convenience initializer
    convenience init(random: Bool) {
        if random {
            let Init = "Default"
            
            let InitImage = UIImage(named:"default.png")
            
            self.init(shoes: Init, shoesImage: InitImage, clothes: Init, clothesImage: InitImage, hats: Init, hatsImage: InitImage, goals: 0)
        }
        else {
            self.init(shoes: "", shoesImage: nil, clothes: "", clothesImage: nil, hats: "", hatsImage: nil, goals: 0)
        }
    }
    
    //Archiving: encodeWithCoder() encodes an intance of "Item" inside the NSCoder instance that is passed in the argument
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(shoes, forKey: "shoes")
        aCoder.encodeObject(shoesImage, forKey: "shoesImage")
        aCoder.encodeObject(clothes, forKey: "clothes")
        aCoder.encodeObject(clothesImage, forKey: "clothesImage")
        aCoder.encodeObject(hats, forKey: "hats")
        aCoder.encodeObject(goals, forKey: "goals")
        aCoder.encodeObject(hatsImage, forKey: "hatsImage")
        aCoder.encodeObject(changeDate, forKey: "changeDate")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        
    }
    
    //Unarchiving: init() creates an object initialized from data in the NSCoder instance that is passed in the argument
    required init(coder aDecoder: NSCoder) {
        shoes = aDecoder.decodeObjectForKey("shoes") as? String
        clothes = aDecoder.decodeObjectForKey("clothes") as? String
        hats = aDecoder.decodeObjectForKey("hats") as? String
        shoesImage = aDecoder.decodeObjectForKey("shoesImage") as? UIImage
        clothesImage = aDecoder.decodeObjectForKey("clothesImage") as? UIImage
        hatsImage = aDecoder.decodeObjectForKey("hatsImage") as? UIImage
        goals = aDecoder.decodeObjectForKey("goals") as? Int
        changeDate = aDecoder.decodeObjectForKey("changeDate") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
    }
}


