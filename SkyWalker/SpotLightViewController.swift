//
//  SpotLightViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit

class SpotLightViewController: UICollectionViewController {
    //reference to ItemStore
    var spotLightItemStore: SpotLightItemStore!
    let layout = UICollectionViewFlowLayout()
    //date formatter
    let dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateStyle = .MediumStyle
        df.timeStyle = .NoStyle
        return df
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if spotLightItemStore == nil{
            spotLightItemStore = SpotLightItemStore();
        }
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        //let ngBarHeight = self.navigationController?.navigationBar.frame.height
        //self.collectionView?.backgroundColor = UIColor.whiteColor()
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        let spacing:CGFloat = 5
        
        layout.minimumInteritemSpacing = spacing
        
        layout.minimumLineSpacing = spacing
        
        
        let collectionViewWidth = self.collectionView!.bounds.width
        let collectionViewHeight = self.collectionView!.bounds.height
        
        let itemWidth = (collectionViewWidth - spacing * CGFloat(2))
        let itemHeight = (collectionViewHeight - statusBarHeight  - spacing * CGFloat(5))
            / CGFloat(4)
        
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
        let cell:SpotLightItemCell  = collectionView.dequeueReusableCellWithReuseIdentifier("SpotLightCell", forIndexPath: indexPath) as! SpotLightItemCell
        let item = spotLightItemStore.allItems[indexPath.row]

        cell.location.text = item.location
        //cell.creator.text = item.author
        //cell.dateCreated.text =  dateFormatter.stringFromDate(item.dateCreated)
        cell.artcle.text=item.article
        let BackGroundImage:UIImageView = UIImageView(frame: cell.bounds)
        BackGroundImage.image  = item.image
        cell.backgroundColor = .clearColor()
        cell.backgroundView = BackGroundImage
        cell.updateLabels()

        return cell;
    }
    //When a segue is triggered, the prepareForSegue(_:sender:) method is called on the view controller initiating the segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       // print("Segue invoked.")
        
        if segue.identifier == "SpotLightItem" {
            if let row = collectionView?.indexPathsForSelectedItems()![0].row {
                let item = spotLightItemStore.allItems[row]
                
                let destinationController = segue.destinationViewController as! DetailSpotLightViewController
                
                //passes a reference of the item to display to the DetailViewController
                destinationController.spotLightitem = item

            }
        }
    }

}