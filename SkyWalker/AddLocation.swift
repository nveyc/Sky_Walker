//
//  AddLocation.swift
//  SkyWalker
//
//  Created by YC, Jiabin on 2017/4/24.
//  Copyright © 2017年 Syracuse University. All rights reserved.
//



import UIKit
import MapKit

////Create the protocol
//protocol DealMapSearch {
//    func dropPinZoomIn(placemark:MKPlacemark)
//}

class SearchViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    //IBOutlet for the map view
    @IBOutlet var mapView: MKMapView!
    var selectedPin:MKPlacemark? = nil
    
    // search bar
    var resultSearchController:UISearchController? = nil
    
    //properties that define where to center the map when it loads
    let intialLocation = CLLocation(latitude: 43.039920, longitude: -76.132553)
    let regionSpan: CLLocationDistance = 2000
    
    // Current Location
    let locationManager = CLLocationManager()
    
//    //array of artwork objects
//    var artworks = [ArtWork]()
    
    func getDirections(){
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
    
    //viewDidLoad() is called when the map view first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets MapViewController as the delegate of the mapView
        mapView.delegate = self
        
        print("MapViewController viewDidLoad")
        
        //???????
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // This triggers the location permission dialog. The user will only see the dialog once.
        locationManager.requestWhenInUseAuthorization()
        // This API call triggers a one-time location request.
        locationManager.requestLocation()
        
        let FoodSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: FoodSearchTable)
        resultSearchController?.searchResultsUpdater = FoodSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        

        
        // This passes along a handle of the mapView from the main View Controller onto the locationSearchTable.
        FoodSearchTable.mapView = mapView
        //FoodSearchTable.DealMapSearchDelegate = self
        
        //centers the map on "intialLocation" with the specified "regionSpan"
        loadMapOnLocation(intialLocation, span: regionSpan)
    }
    
    //viewWillAppear() is called right before the view of DetailViewController comes onscreen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DetailViewController viewWillAppear.")
        //navigationItem.title = "abc"
    }
    
    //viewWillDisappear is called right before the view of DetailViewController disappears
    //The function in our case is used to save the values of the three textFields
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("DetailViewController viewWillDisappear.")
    }
    
    //loadMapOnLocation() loads the map on the specified location with the specified span
    func loadMapOnLocation(location: CLLocation, span: CLLocationDistance) {
        //let region = MKCoordinateRegionMakeWithDistance(location.coordinate, span * 2, span * 2)
        
        //mapView.setRegion(region, animated: true)
    }
    
    //mapView(:annotationView:calloutAccessoryControlTapped:) tells the delegate that the user tapped one of the annotation view’s accessory buttons.
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)
        
//        if let artwork = view.annotation as? ArtWork {
//            //launches maps with the specified launch options
//            artwork.mapItem().openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
//        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            //let region = MKCoordinateRegion(center: location.coordinate, span: span)
            //mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
    
    func dropPinZoomIn(placemark: MKPlacemark){
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
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        pinView?.pinTintColor = UIColor.orangeColor()
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), forState: .Normal)
        //button.addTarget(self, action: #selector(MapViewController.getDirections), forControlEvents: .TouchUpInside)
        pinView?.leftCalloutAccessoryView = button
        
        return pinView
    }
    
}





