//
//  Location.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/3.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import CoreLocation
import Foundation

class Location: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var lat: String!
    var long: String!
    
    var locationString: String {
        return "\(String(describing: lat)),\(String(describing: long))"
    }
    
    override init() {
        super.init()
        self.lat = getLocation().0
        self.long = getLocation().1
    }
    
    func getLocation() -> (String, String) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        let latitude = locationManager.location?.coordinate.latitude ?? 0.0
        let longitude = locationManager.location?.coordinate.longitude ?? 0.0

        return("\(latitude)", "\(longitude)")
    }
}

