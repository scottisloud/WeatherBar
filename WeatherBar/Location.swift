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
	
	// MARK: Location-related objects
	let locationManager = CLLocationManager()
	var lat: Double = 0.0
	var long: Double = 0.0
	var locationName = ""
	var coordString: String

	override init() {
		coordString = "\(self.lat),\(self.long)"
	}

	// MARK: GET USER LOCATION
	func getLocation() -> (lat: Double, long: Double, locString: String) {
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
			locationManager.startUpdatingLocation()
			
			lat = locationManager.location?.coordinate.latitude ?? 0.0
			long = locationManager.location?.coordinate.longitude ?? 0.0
			
			print("Location services enabled!")
			return (lat, long, "\(lat),\(long)")
			
		} else {
			print("Location services not enabled")
			return (0.0, 0.0, "")
		}
	}
	
	
	func getLocationName(lat: Double, long: Double) {
		
		let geocoder = CLGeocoder()
		guard let location = CLLocationManager().location else { return }
		geocoder.reverseGeocodeLocation(location) { placemarks, error in
			guard error == nil else {
				print("Oops")
				return
			}
			
			if let firstPlacemark = placemarks?.first?.locality {
				self.locationName = firstPlacemark
			}
		}
		
	}
	
}

