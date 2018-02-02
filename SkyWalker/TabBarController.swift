//
//  TabBarController.swift
//  SkyWalker
//
//  Created by YC on 2017/4/21.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate
{
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if viewController == self.viewControllers![2]  {
            
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let vc = sb.instantiateViewControllerWithIdentifier("AddNew") as! AddNewViewController
            
            self.presentViewController(vc, animated: true, completion: nil)
            return false
        }
            
        else {
            return true
        }
    }
}
