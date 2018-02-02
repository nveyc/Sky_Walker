//
//  DiscoveryViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class DiscoveryViewController: UICollectionViewController {
    
    var discoveryItemStore: DiscoveryItemStore!
    let layout = UICollectionViewFlowLayout()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            if discoveryItemStore == nil{
                discoveryItemStore = DiscoveryItemStore();
            }
            let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
            let ngBarHeight = self.navigationController?.navigationBar.frame.height
            self.collectionView?.backgroundColor = UIColor.whiteColor()
            let layout = self.collectionViewLayout as! UICollectionViewFlowLayout

            let spacing:CGFloat = 5

            layout.minimumInteritemSpacing = spacing
 
            layout.minimumLineSpacing = spacing
            

            let columnsNum = 2
 
            let collectionViewWidth = self.collectionView!.bounds.width
            let collectionViewHeight = self.collectionView!.bounds.height

            let itemWidth = (collectionViewWidth - spacing * CGFloat(3))
                / CGFloat(columnsNum)
            let itemHeight = (collectionViewHeight - statusBarHeight - ngBarHeight! * 2 - spacing * CGFloat(4))
                / CGFloat(columnsNum)

            layout.itemSize = CGSize(width:itemWidth, height:itemHeight)
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        //UICollectionViewDataSource
        override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            return 4;
        }
        
        //UICollectionViewDataSource
        override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
        {
            let cell:DiscoveryItemCell  = collectionView.dequeueReusableCellWithReuseIdentifier("DiscoveryCell", forIndexPath: indexPath) as! DiscoveryItemCell
            var item: DiscoveryItem!
            let BackGroundImage:UIImageView = UIImageView(frame: cell.bounds)
           
 
            if indexPath.row == 0 {
                item = discoveryItemStore.FItems[0]
                 BackGroundImage.image  = UIImage(named:"Guide.png")
                cell.CatagoryLabel.text = "Guide"
            }
            else if indexPath.row == 1 {
                item = discoveryItemStore.SItems[0]
                 BackGroundImage.image  = UIImage(named:"Hotel.png")
                cell.CatagoryLabel.text = "Hotel"
            }
            else if indexPath.row == 2 {
                item = discoveryItemStore.TItems[0]
                 BackGroundImage.image  = UIImage(named:"Restaurant.png")
                cell.CatagoryLabel.text = "Restaurant"
            }
            else if indexPath.row == 3 {
                item = discoveryItemStore.FrItems[0]
                 BackGroundImage.image  = UIImage(named:"Transit.png")
                cell.CatagoryLabel.text = "Transit"
            }
            
            cell.backgroundColor = .clearColor()
            cell.backgroundView = BackGroundImage

            return cell;
        }
    
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue invoked.")
        var items: [DiscoveryItem]?
        if segue.identifier == "DiscoveryItem" {
            print("111111")
            if let row = collectionView?.indexPathsForSelectedItems()![0].row {
                if row == 1{
                   items = discoveryItemStore.FItems
                }
                if row == 2{
                    items = discoveryItemStore.SItems
                }
                if row == 3{
                    items = discoveryItemStore.TItems
                }
                if row == 0{
                    items = discoveryItemStore.FrItems
                }
                
                let destinationController = segue.destinationViewController as! DiscoverySelectionViewController
                
                //passes a reference of the item to display to the DetailViewController
                destinationController.discoveryItems = items
                
            }
        }
    }

}