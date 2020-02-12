//
//  Location.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/3.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import CoreLocation
import Foundation



/// Class can fetch the users current location with getLocation(). Returns a tuple (lat: Double, long: Double, "lat,long": String)
/// Class also gets the current location's name and sets the class's locationName property.

class Location: NSObject, CLLocationManagerDelegate {
    
    // MARK: Location-related objects
    let locationManager = CLLocationManager()
    
    var lat: Double = 0.0
    var long: Double = 0.0
    var coordString: String
    var locationName: String = ""
    var userCurrentLocation: CLLocation?
    
    override init() {
        coordString = "\(self.lat),\(self.long)"
        
    }
    
    // MARK: GET USER LOCATION
    func getLocation() -> (lat: Double, long: Double, locString: String) {
        print("getLocation() called")
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
            
            lat = locationManager.location?.coordinate.latitude ?? 0.0
            long = locationManager.location?.coordinate.longitude ?? 0.0
            userCurrentLocation = locationManager.location
            
            print("Location services enabled!")
            print("\(lat),\(long)")
            return (lat, long, "\(lat),\(long)")
            
        } else {
            print("Location services not enabled")
            return (0.0, 0.0, "")
        }
    }
    
    typealias GetPlacemarkCompletionHandler = (CLPlacemark?, Error?) -> Void
    
    func getLocationPlacemark(completionHandler completion: @escaping GetPlacemarkCompletionHandler) {
        print("getLocationPlacemark() called")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        let geocoder = CLGeocoder()
        guard let location = CLLocationManager().location else { return }
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                completion(nil, DarkSkyError.cannotGetLocation)
                return
            }
            if let placemarks = placemarks {
                completion(placemarks.first, nil)
            }
        }
    }
    
    func getLocationName(completionHandler completion: @escaping (String?, Error?) -> Void) {
        print("getLocationName() called")
        getLocationPlacemark() { placemark, error in
            completion(placemark?.locality, DarkSkyError.cannotGetLocation)
        }
    }
}
