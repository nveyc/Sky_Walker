//
//  DiscoveryItem.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class DiscoveryItem: NSObject, NSCoding {
    var name: String
    var valueInDollars: String?
    var serialNumber: String?
    var url: NSURL?
    var image:UIImage?
    let dateCreated: NSDate
    var catagory:String?
    //var image: UIImage?
    let itemKey: String
    
    //designated intializer
    init(name: String, valueInDollars: String?, serialNumber: String?, catagory: String?, image: UIImage?, url: NSURL?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.catagory = catagory
        self.dateCreated = NSDate()
        self.image = image
        self.url = url
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    //convenience initializer
    convenience init(random: Int?) {
        if let num = random{
            let names = ["Garen's Hotel", "Ezearl's Hotel", "Lux's Hotel","Garen's Restaurant","Ezearl's Airline","Ezreal's Airline","Graves's Guiders"]
            let averageDollar = ["550", "450", "1000","20/person","1000","1000","500"]
            let image = [UIImage(named:"hotel1.png"),UIImage(named:"hotel2.png"),UIImage(named:"hotel3.png"),UIImage(named:"restaurant1.png"),UIImage(named:"airline1.png"),UIImage(named:"airline2.png"),UIImage(named:"guide1.png")]
            var urls: [NSURL] = []
            urls.append(NSURL(string:"https://www.tripadvisor.com/Hotel_Review-g60763-d99762-Reviews-Hotel_Giraffe_by_Library_Hotel_Collection-New_York_City_New_York.html")!)
            urls.append(NSURL(string:"https://www.tripadvisor.com/Hotel_Review-g60763-d10131859-Reviews-Even_Hotel_New_York_Midtown_East-New_York_City_New_York.html")!)
            urls.append(NSURL(string:"https://www.tripadvisor.com/Hotel_Review-g60763-d3344640-Reviews-Refinery_Hotel-New_York_City_New_York.html")!)
            urls.append(NSURL(string:"https://www.tripadvisor.com/Restaurant_Review-g60763-d425628-Reviews-Per_Se-New_York_City_New_York.html")!)
            urls.append(NSURL(string:"https://www.tripadvisor.com/CheapFlightsSearchResults-g60763-a_airport0.SYR-a_airport1.NYC-a_cos.0-a_date0.20170512-a_date1.20170515-a_nearby0.no-a_nearby1.no-a_nonstop.no-a_pax0.a-a_travelers.1-New_York_City_New_York.html")!)
            urls.append(NSURL(string:"https://www.tripadvisor.com/CheapFlightsSearchResults?date0=20170512&date1=20170515&nearby0=no&nearby1=no&airport0=CHI&airport1=NYC&pax0=a&travelers=1&geo=60763&cos=0&nonstop=no")!)
            urls.append(NSURL(string:"https://www.booking.com/destinationfinder/cities/us/kailua.html?aid=331424;sid=2de75f63ca5beaa6a5e088479cdd464f;dsf_source=1;dsf_pos=1")!)
            
            
            let rname = names[num]
            let rdollar = averageDollar[num]
            let rimg = image[num]
            let rULR = urls[num]
            let rSerial = "SN" + "\(arc4random_uniform(101))"
            var rCata : String?
            if num < 3{
                 rCata = "Hotel"
            }
            else if num > 2 && num < 4{
                 rCata = "Restaurant"
            }
            else if num > 3 && num < 6{
                 rCata = "Airline"
            }
            else {
                 rCata = "Guiders"
            }
            self.init(name: rname, valueInDollars: rdollar, serialNumber: rSerial, catagory: rCata, image: rimg, url:rULR)
        }
        else {
            self.init(name: "", valueInDollars: "", serialNumber: "", catagory: "", image: nil, url:nil)
        }
    }
    
    //Archiving: encodeWithCoder() encodes an intance of "Item" inside the NSCoder instance that is passed in the argument
    func encodeWithCoder(aCoder: NSCoder) {
        print("encodeWithCoder: \(name)")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        aCoder.encodeObject(valueInDollars, forKey: "valueInDollars")
        aCoder.encodeObject(catagory,forKey: "catagory")
        aCoder.encodeObject(image,forKey: "image")
        aCoder.encodeObject(url,forKey: "url")
    }
    
    //Unarchiving: init() creates an object initialized from data in the NSCoder instance that is passed in the argument
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String?
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        catagory = aDecoder.decodeObjectForKey("catagory")as? String
        image = aDecoder.decodeObjectForKey("image")as? UIImage
        valueInDollars = aDecoder.decodeObjectForKey("valueInDollars")as? String
        url = aDecoder.decodeObjectForKey("url")as? NSURL
    }
}
