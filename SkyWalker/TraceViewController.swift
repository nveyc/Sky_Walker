//
//  TraceViewController.swift
//  SkyWalker
//
//  Created by Jiabin, YC on 2017/4/20.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//

import UIKit
import MapKit

class TraceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate{
    
    
    @IBOutlet var temptextView: UITextView?
    @IBOutlet var img: UIImageView?
    
    @IBOutlet var mapView: MKMapView?
    
    var mapItems = [MapItem]()
    
    
    let intialLocation = CLLocation(latitude: 43.0368, longitude: -76.1405)
    let regionSpan: CLLocationDistance = 10000
    
    
    @IBAction func onSegmentItemClicked(sender: AnyObject) {//点击segment切换页面函数
        // NSLog(String(sender.selectedSegmentIndex),"")
        switch(sender.selectedSegmentIndex){
        case 1:
            print("map")
            timelineTableView.hidden = true
            mapView?.hidden = false
            mapItems.removeAll()
            showMapItem()
            
            
            break
        default:
            print("timeline")
            timelineTableView.hidden = false
            mapView?.hidden = true
            break
            
        }
    }
    
    
    @IBOutlet weak var timelineTableView: UITableView!
    
    var jorneyitemStore: JourneyStore!
    var backimage = [UIImage(named:"TraceBackGround.png")]
    var cellbkl = [UIImage(named:"blue.png"),UIImage(named:"green.png"),UIImage(named:"orange.png"),UIImage(named:"yellow.png"),UIImage(named:"red.png"),UIImage(named:"RoseRed.png")]
    var cellbkr = [UIImage(named:"blueR.png"),UIImage(named:"greenR.png"),UIImage(named:"orangeR.png"),UIImage(named:"yellowR.png"),UIImage(named:"redR.png"),UIImage(named:"RoseRedR.png")]
    let dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateStyle = .MediumStyle
        df.timeStyle = .NoStyle
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.img?.image = UIImage(named:"clock.png")
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        timelineTableView.backgroundColor = UIColor.clearColor()
        timelineTableView.backgroundView = UIImageView(image: backimage[0])

        
        mapView?.hidden = true
        mapView!.delegate = self
        loadMapOnLocation(intialLocation, span: regionSpan)
    }
    
    
    func loadMapOnLocation(location: CLLocation, span: CLLocationDistance) {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, span * 2, span * 2)
        
        mapView!.setRegion(region, animated: true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        jorneyitemStore = JourneyStore()
        self.timelineTableView.reloadData()
        mapItems.removeAll()
        showMapItem()
    }
    override func viewDidDisappear(animated: Bool) {
        self.jorneyitemStore.saveChanges()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {

        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jorneyitemStore.allItems.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(#function)
        
        if editingStyle == .Delete {
            let item = jorneyitemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.title)?"
            let message = "Are you sure?"
            
            //UIAlertController
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            //Cancel Action
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            //Delete Action
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {(delete) -> Void in
                //deletes the item from the array
                self.jorneyitemStore.removeItem(item)

                //deletes the row in the tableView the user wants to delete
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                self.timelineTableView.reloadData()
            })
            
            ac.addAction(deleteAction)

            presentViewController(ac, animated: true, completion: nil)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell1: TimelineLeftCell!
        var cell2: TimelineRightCell!
        let item = jorneyitemStore.allItems[indexPath.row]
        var num: Int!{
            return indexPath.row % 6
        }
        if indexPath.row % 2 == 0 {
            cell1 = tableView.dequeueReusableCellWithIdentifier("TimelineLeftCell",forIndexPath: indexPath)as! TimelineLeftCell
            cell1.backgroundView = UIImageView(image:cellbkl[num])
            
            
            let paraph = NSMutableParagraphStyle()
            // set the line space
            paraph.lineSpacing = 0

            let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(16),
                              NSParagraphStyleAttributeName: paraph]

            cell1.title.attributedText = NSAttributedString(string: item.title, attributes: attributes)
            cell1.title.textAlignment = .Center
            cell1.timeDate.text = dateFormatter.stringFromDate(item.dateCreated)
            cell1.location.text = item.location?.name
            if item.location?.name != "" && item.location != nil {
            cell1.img.image = UIImage(named:"locationIcon.png")
            }
            else {
            cell1.img.image = nil
            }
            cell1.backgroundColor = UIColor.clearColor()
            return cell1
        }
        else {
            cell2 = tableView.dequeueReusableCellWithIdentifier("TimelineRightCell",forIndexPath: indexPath)as! TimelineRightCell
            
            cell2.backgroundView = UIImageView(image:cellbkr[num])
            
            let paraph = NSMutableParagraphStyle()
            // set the line space
            paraph.lineSpacing = 0
            
            let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(16),
                              NSParagraphStyleAttributeName: paraph]
            
            
            cell2.title.attributedText = NSAttributedString(string: item.title, attributes: attributes)
            cell2.title.textAlignment = .Center
            cell2.timeDate.text = dateFormatter.stringFromDate(item.dateCreated)
            cell2.location.text = item.location?.name
            if item.location?.name != "" && item.location != nil{
                cell2.img.image = UIImage(named:"locationIcon.png")
            }
            else {
                cell2.img.image = nil
            }
            cell2.contentView.transform = CGAffineTransformMakeScale(-1,1)
            cell2.img?.transform = CGAffineTransformMakeScale(-1,1)
            cell2.location.transform = CGAffineTransformMakeScale(-1,1)
            cell2.title.transform = CGAffineTransformMakeScale(-1,1)
            cell2.timeDate.transform = CGAffineTransformMakeScale(-1,1)
            cell2.backgroundColor = UIColor.clearColor()
            return cell2
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 110
        
    }
    
    

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        print("\(#function) \(annotation.title)")
        
        if let artwork = annotation as? MapItem {
            let identifier = "pin"
            var pinAnnotationView: MKPinAnnotationView
            
            
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as?
                MKPinAnnotationView {
                dequeuedView.annotation = artwork
                pinAnnotationView = dequeuedView
            }
                
            else {
                pinAnnotationView = MKPinAnnotationView(annotation: artwork, reuseIdentifier: identifier)
                pinAnnotationView.canShowCallout = true
                pinAnnotationView.calloutOffset = CGPoint(x: -5, y:5)
                pinAnnotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
                
            }
            
            pinAnnotationView.pinTintColor = artwork.pinColor()
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)
        

        for i in 0..<jorneyitemStore.allItems.count{
            if jorneyitemStore.allItems[i].location?.name  ==  (view.annotation?.title)!{
                performSegueWithIdentifier("mapItem", sender: i)
                break
            }
        }
        
    }
    
    func showMapItem()
    {
        mapView?.removeAnnotations((mapView?.annotations)!)
        jorneyitemStore = JourneyStore()
        if jorneyitemStore.allItems.count > 0
        {
            for i in 0...jorneyitemStore.allItems.count-1
                
            {
                let item = MapItem(title: jorneyitemStore.allItems[i].location!.name!, subtitle: "", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: jorneyitemStore.allItems[i].location!.latitude, longitude: jorneyitemStore.allItems[i].location!.longtitude))
                mapItems.append(item)
            }
        }
        mapView!.addAnnotations(mapItems)
    }
    
    
    //When a segue is triggered, the prepareForSegue(_:sender:) method is called on the view controller initiating the segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue invoked.")
        
        if segue.identifier == "traceItem1" || segue.identifier == "traceItem2" {
            if let row = self.timelineTableView.indexPathForSelectedRow?.row {
                let item = jorneyitemStore.allItems[row]
                
                let destinationController = segue.destinationViewController as! DetailJourneyViewController
                
                //passes a reference of the item to display to the DetailViewController
                destinationController.rows = row
                
            }
        }
        if segue.identifier == "mapItem"{
            let destinationController = segue.destinationViewController as! DetailJourneyViewController
            
            //passes a reference of the item to display to the DetailViewController
            destinationController.rows = sender as? Int
        }
    }
    
}