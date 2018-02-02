//
//  Item.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class SpotLightItem: NSObject, NSCoding {
    var location: String
    var author: String
    var article: String?
    var Serialnum: String?
    var imageNum:Int?
    var url: NSURL?
    let dateCreated: NSDate
    var image: UIImage?
    let itemKey: String
    
    //designated intializer
    init(location: String, author: String, article: String?, serialNum: String?,image: UIImage?,imgNum:Int?,url: NSURL?) {
        self.location = location
        self.author = author
        self.article = article
        self.Serialnum = serialNum
        self.url = url
        self.dateCreated = NSDate()
        self.image=image
        self.itemKey = NSUUID().UUIDString
        self.imageNum=imgNum
        super.init()
    }
    
    //convenience initializer
    convenience init(random: Int?) {
        if let num = random{
            let ads = ["Yosemite", "New York", "Yellowstone","Hawaii","San Francisco","Beijing","New Delhi"]
            let aths = ["Camile", "WuKong", "Graves","Garen","Riven","Ezearl","Syracuse"]
            let article = ["This is a good place 1","This is a good place 2 ","This is a good place 3","This is a good place 4","This is a good place 5","This is a good place 6"]
            let image = [UIImage(named:"Yosemite.png"),UIImage(named:"NewYork.png"),UIImage(named:"YellowStone.png"),UIImage(named:"Hawaii.png"),UIImage(named:"SanFrancisco.png"),UIImage(named:"Beijing.png"),UIImage(named:"NewDelhi.png")]
            var urls: [NSURL] = []
            urls.append(NSURL(string:"https://www.tripadvisor.com/Tourism-g61000-Yosemite_National_Park_California-Vacations.html")!)
            urls.append(NSURL(string:"https://www.tripadvisor.com/Guide-g60763-k18-New_York_City_New_York.html")!)
            urls.append(NSURL(string:"https://www.tripadvisor.com/Tourism-g60999-Yellowstone_National_Park_Wyoming-Vacations.html")!)
            urls.append(NSURL(string:"https://www.booking.com/destinationfinder/cities/us/kailua.html?aid=331424;sid=2de75f63ca5beaa6a5e088479cdd464f;dsf_source=1;dsf_pos=1")!)
            urls.append(NSURL(string:"https://www.booking.com/destinationfinder/cities/us/san-francisco.html?aid=331424;sid=2de75f63ca5beaa6a5e088479cdd464f;dsf_source=13")!)
            urls.append(NSURL(string:"https://www.booking.com/destinationfinder/cities/cn/beijing.html?aid=331424;sid=2de75f63ca5beaa6a5e088479cdd464f;dsf_source=13")!)
            urls.append(NSURL(string:"https://www.booking.com/destinationfinder/cities/in/new-delhi.html?aid=331424;sid=2de75f63ca5beaa6a5e088479cdd464f;dsf_source=13")!)
            let randomAds = ads[num]
            let randomAths = aths[num]
            let randomAtc=article[num]
            let randomNum=num
            let randomULR=urls[num]
            let randomImg=image[num]
            let randomSerial = "SN" + "\(arc4random_uniform(101))"
            
            self.init(location: randomAds, author: randomAths, article: randomAtc, serialNum: randomSerial,image: randomImg,imgNum: randomNum,url:randomULR)
        }
        else {
            self.init(location: "", author: "", article: "",serialNum: "",image: nil,imgNum: nil,url: nil)
        }
    }
    
    //Archiving: encodeWithCoder() encodes an intance of "Item" inside the NSCoder instance that is passed in the argument
    func encodeWithCoder(aCoder: NSCoder) {
        print("encodeWithCoder: \(location)")
        aCoder.encodeObject(location, forKey: "location")
        aCoder.encodeObject(author, forKey: "author")
        aCoder.encodeObject(article, forKey: "article")
        aCoder.encodeObject(Serialnum, forKey: "serialNumber")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        
    }
    
    //Unarchiving: init() creates an object initialized from data in the NSCoder instance that is passed in the argument
    required init(coder aDecoder: NSCoder) {
        location = aDecoder.decodeObjectForKey("location") as! String
        author = aDecoder.decodeObjectForKey("author") as! String
        article = aDecoder.decodeObjectForKey("article") as? String
        Serialnum = aDecoder.decodeObjectForKey("serialNumber") as! String?
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        
    }
}
