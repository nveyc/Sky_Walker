//
//  DiscoveryItemStore.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import Foundation

class DiscoveryItemStore {
    var FItems = [DiscoveryItem]()
    var SItems = [DiscoveryItem]()
    var TItems = [DiscoveryItem]()
    var FrItems = [DiscoveryItem]()

    
    //creates the allItems array from the data saved in the archive
    init() {
        createItem()
    }
    
    //creates an item, inserts it in the array, and returns the created item
    func createItem() {
            for i in 0...2{
            let item1 = DiscoveryItem(random: i)
            FItems.append(item1)
            }
            let item2 = DiscoveryItem(random: 3)
                SItems.append(item2)
            for q in 4...5{
                let item3 = DiscoveryItem(random: q)
                TItems.append(item3)
            }
            let item4 = DiscoveryItem(random: 6)
            FrItems.append(item4)
    }
    
    //function to print all items in the array
    func printAllItems() {
        for item in FItems {
            print("Name: \(item.name) Value: \(item.valueInDollars) SN: \(item.serialNumber) Date: \(item.dateCreated)")
        }
        for item in SItems {
            print("Name: \(item.name) Value: \(item.valueInDollars) SN: \(item.serialNumber) Date: \(item.dateCreated)")
        }
        for item in FItems {
            print("Name: \(item.name) Value: \(item.valueInDollars) SN: \(item.serialNumber) Date: \(item.dateCreated)")
        }
        for item in FrItems {
            print("Name: \(item.name) Value: \(item.valueInDollars) SN: \(item.serialNumber) Date: \(item.dateCreated)")
        }
    }
}
