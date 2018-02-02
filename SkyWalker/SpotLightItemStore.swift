//
//  ItemStore.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import Foundation

class SpotLightItemStore {
    var allItems = [SpotLightItem]()
    var nums=[Int]()
        init() {
            nums = [0,1,2,3,4,5]
            for _ in 0..<4 {
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                createItem(nums[index])
                nums.removeAtIndex(index)
            }
        }
    //creates an item, inserts it in the array, and returns the created item
    func createItem(num: Int?) -> SpotLightItem {
        let item = SpotLightItem(random: num)
        
        allItems.append(item)
        //allItems.insert(item, atIndex: 0)
        
        return item
    }
    
    func printAllItems() {
        for item in allItems {
            print("Location: \(item.location) Author: \(item.author) SN: \(item.Serialnum) Date: \(item.dateCreated) Article: \(item.article)")
        }
    }
}
