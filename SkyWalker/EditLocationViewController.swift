//
//  LocationSearch.swift
//  SkyWalker
//
//  Created by YC on 2017/4/24.
//  Copyright © 2017年 JiabinJiabinSyracuse University. All rights reserved.
//


import UIKit
import MapKit




class EditLocationSearchTable : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate,UITableViewDataSource
, UISearchBarDelegate,UISearchResultsUpdating{
    
    
    // Search queries rely on a map region to prioritize local results.
    @IBOutlet var mapView: MKMapView? = nil
    
    
    var reLocation: MKCoordinateRegion? = nil
    var locationStore = locationItemStore()
    
    var selectedPin: MKPlacemark? = nil
    
    @IBOutlet var tableV: UITableView!
    //    //var handleMapSearchDelegate: HandleMapSearch? = nil
    //    var DealMapSearchDelegate: DealMapSearch? = nil
    
    // You will use this later on to stash search results for easy access
    var matchingItems:[MKMapItem] = []
    
    
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // Current Location
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableV.delegate = self
        tableV.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        
        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        tableV!.tableHeaderView = searchController.searchBar
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        view.endEditing(true)
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
    
    func dropPinZoomIn(placemark: MKPlacemark) -> MKCoordinateRegion {
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        //mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        return region
    }
    
    
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        //handleMapSearchDelegate?.dropPinZoomIn(selectedItem)
        reLocation = dropPinZoomIn(selectedItem)
        locationStore.locationItems.latitude = (reLocation?.center.latitude)!
        locationStore.locationItems.longtitude = (reLocation?.center.longitude)!
        locationStore.locationItems.name = selectedItem.name
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // The matchingItems array determines the number of table rows.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem)
        return cell
    }
    
    @IBAction func cancleClick(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension EditLocationSearchTable {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        // MKLocalSearch performs the actual search on the request object.
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        //startWithCompletionHandler() executes the search query and returns a MKLocalSearchResponse object which contains an array of mapItems.
        search.startWithCompletionHandler { response, _ in
            guard let response = response else {
                return
            }
            
            self.matchingItems = response.mapItems
            self.tableV!.reloadData()
        }
    }
}







