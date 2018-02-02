//
//  MeItem.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/22.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//


import UIKit

class MeItem: NSObject, NSCoding {
    var name: String
    var email: String
    var photo: UIImage?
    var Sex: String
    var changeDate: NSDate
    //var image: UIImage?
    let itemKey: String
    
    //designated intializer
    init(name: String, email: String, photo: UIImage? ,Sex: String) {
        self.name = name
        self.email = email
        self.photo = photo
        self.Sex = Sex
        self.changeDate = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    //convenience initializer
    convenience init(random: Bool) {
        if random {
            let InitName = "Default"
            
            let InitEmail = "Enjoy Yourself"
            let Initphoto = UIImage(named:"default.png")
            let Initsex = "Male"
            
            self.init(name: InitName, email: InitEmail, photo: Initphoto, Sex: Initsex )
        }
        else {
            self.init(name: "", email: "", photo: nil, Sex:"")
        }
    }
    
    //Archiving: encodeWithCoder() encodes an intance of "Item" inside the NSCoder instance that is passed in the argument
    func encodeWithCoder(aCoder: NSCoder) {
        print("encodeWithCoder: \(name)")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(photo, forKey: "photo")
        aCoder.encodeObject(Sex, forKey: "Sex")
        aCoder.encodeObject(changeDate, forKey: "changeDate")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        
    }
    
    //Unarchiving: init() creates an object initialized from data in the NSCoder instance that is passed in the argument
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        email = aDecoder.decodeObjectForKey("email") as! String
        photo = aDecoder.decodeObjectForKey("photo") as! UIImage?
        Sex = aDecoder.decodeObjectForKey("Sex") as! String
        changeDate = aDecoder.decodeObjectForKey("changeDate") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
    }
}

