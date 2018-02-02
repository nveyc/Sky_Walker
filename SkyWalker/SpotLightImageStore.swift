//
//  SpotLightImageStore.swift
//  SkyWalker
//
//  Created by Jiabin on 2017/4/20.
//  Copyright © 2017年 JiabinJiabinSyracuse University. All rights reserved.
//

import UIKit

class SpotLightImageStore {
    var images = [UIImage]()
    
    init(nums:[Int],items:SpotLightItemStore){
        let imgSets = [[UIImage(named:"1.png"),UIImage(named:"1.png")],[UIImage(named:"1.png")]]
        for i in 0..<4{
            images.append(imgSets[items.allItems[i].imageNum])
        }
    }
}