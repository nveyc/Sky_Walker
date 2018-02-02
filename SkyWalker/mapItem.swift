//
//  ArtWork.swift
//  WorldTrotter
//
//  Created by Swastik Brahma on 2/16/17.
//  Copyright © 2017 Syracuse University. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class MapItem: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    
    let category: String
    
    
    let coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle: String, category: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        
        self.category = category
        self.coordinate = coordinate
        
        super.init()
    }
    
    func mapIter() -> MKMapItem {
        let addressDictionary = [CNPostalAddressStreetKey: "waikiki Gateway Park", CNPostalAddressStateKey: "Hawaii", CNPostalAddressCountryKey: "USA"]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        return mapItem
    }
    
    func pinColor() -> UIColor {
        switch category {
        case "Statue":
            return UIColor.blueColor()
        case "Monmument":
            return UIColor.redColor()
        default:
            return UIColor.greenColor()
        }
    }
}