//
//  ViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

// API Key: "960281f5a5cd1551f2f0446c79928e58"

import Cocoa
import CoreLocation

class ViewController: NSViewController, CLLocationManagerDelegate {
    
    // MARK: Interface-related constants
    @IBOutlet weak var icon: NSImageView!
    @IBOutlet weak var temperature: NSTextField!
    @IBOutlet weak var summary: NSTextField!
    @IBOutlet weak var precipValue: NSTextField!
    @IBOutlet weak var humidityValue: NSTextField!
    @IBOutlet weak var windSpeedValue: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var unitControl: NSSegmentedControl!
    @IBOutlet weak var refresh: NSButton!
    @IBOutlet weak var quit: NSButton!
    @IBOutlet weak var darkSkyLink: NSTextField!
    

    let bgColor = NSColor.systemOrange
    
    var metric: Int = 0
    
    // MARK: API-related objects
    fileprivate let darkSkyApiKey = "960281f5a5cd1551f2f0446c79928e58"
    var baseUrl: URL {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }
    var jsonFeed: JSON?
    
    // MARK: Location-related objects
    let locationManager = CLLocationManager()
    var lat: Double = 0.0
    var long: Double = 0.0
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInterface()
        let defaults = UserDefaults.standard
        let units = defaults.integer(forKey: "units")
        let location = getLocation()
        fetchData(location: location, units: units)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        let defaults = UserDefaults.standard
        metric = defaults.integer(forKey: "units")
        unitControl.selectedSegment = metric
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    //MARK: SET UP GENERAL APPEARANCE
    func setUpInterface() {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.stringValue = "Current Conditions"
//        darkSkyLink.stringValue = "Powered by DarkSky"
        // Sets background of view to orange
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bgColor.cgColor
        
        // Set button titles
        refresh.image = NSImage(named: "NSRefreshTemplate")
        unitControl.setLabel("ºC", forSegment: 0)
        unitControl.setLabel("ºF", forSegment: 1)
		
		
		// TODO: Set up and style DarkSky credit and link
		let attributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.foregroundColor: NSColor.linkColor,
			NSAttributedString.Key.link: NSURL(string: "https://darksky.net/poweredby/")!
		]
		let darkSkyAttributedString = NSMutableAttributedString(string: "Powered by DarkSky", attributes: attributes)
		
		darkSkyLink.attributedStringValue = darkSkyAttributedString
		
		
        quit.title = "Quit"
    }
    
    // MARK: GET USER LOCATION
    func getLocation() -> (String) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        
        lat = locationManager.location?.coordinate.latitude ?? 0.0
        long = locationManager.location?.coordinate.longitude ?? 0.0
        
        return "\(lat),\(long)"
    }
    
    
    //MARK: CONNECT TO API AND RETRIEVE DATA
    func fetchData(location: String, units: Int) {
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            var symbol = ""
            if units == 0 {
                symbol = "?units=ca"
            } else {
                symbol = "?units=us"
            }
            
            guard let dataUrl = URL(string: "\(location)\(symbol)", relativeTo: self.baseUrl) else { print("Invalid URL Request"); return }
            print(dataUrl)
            guard let data = try? String(contentsOf: dataUrl) else {
                DispatchQueue.main.async {
                    print("Bad API call")
                }
                return
            }
            let newData = JSON(parseJSON: data)
        
            DispatchQueue.main.async {
                self.jsonFeed = newData
                self.updateDisplay()
            }
        }
    }
    
    @IBAction func selectUnits(_ sender: NSSegmentedControl) {
        if unitControl.selectedSegment == 0 {
            metric = 0
            fetchData(location: getLocation(), units: metric)
        } else {
            metric = 1
            fetchData(location: getLocation(), units: metric)
        }
        
        let defaults = UserDefaults.standard
        defaults.set(unitControl.selectedSegment, forKey: "units")
        
    }
    
    func updateDisplay() {
        guard let feed = jsonFeed else { print("Error with feed"); return }
        if let weatherIcon = feed["currently"]["icon"].string {
            icon?.image = NSImage(named: weatherIcon)
        } else {
            print("ERROR ASSIGNING ICON VALUE")
        }
        if let temp = feed["currently"]["temperature"].int {
            var units = "C"
            if metric == 1 {
                units = "F"
            }
            temperature?.stringValue = "\(temp)º\(units)" // TODO: Display correct units
        } else {
            print("ERROR ASSIGNING TEMPERATURE VALUE")
        }
        if let sum = feed["currently"]["summary"].string {
            summary?.stringValue = sum
        } else {
            print("ERROR ASSIGNING SUMMARY VALUE")
        }
        if let precip = feed["currently"]["precipProbability"].double {
            precipValue?.stringValue = "\(precip * 100)%"
        } else {
            print("ERROR ASSIGNING PRECIPITATION VALUE")
        }
        if let wind = feed["currently"]["windSpeed"].int {
            var units = "kph"
            if metric == 1 {
                units = "mph"
            }
            windSpeedValue?.stringValue = "\(wind) \(units)" // TODO: Units
        } else {
            print("ERRROR ASSIGNING WINDSPEED VALUE")
        }
        if let hum = feed["currently"]["humidity"].double {
            humidityValue?.stringValue = "\(hum * 100)%"
        } else {
            print("ERROR ASSIGNING HUMIDITY VALUE")
        }
        
        
    }
    
    @IBAction func refreshClicked(_ sender: NSButton) {
        let loc = getLocation()
        fetchData(location: loc, units: metric)
    }
	
    
    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
    
	
	
    @IBAction @objc func darkSkyClicked(_ sender: Any) {
		
		NSWorkspace.shared.open(URL(string: "https://darksky.net/poweredby/")!)
    }
}


