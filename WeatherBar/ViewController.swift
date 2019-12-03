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
    
    let bgColor = NSColor(srgbRed: 0.992, green: 0.632, blue: 0.0117, alpha: 1)
    
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
    var location: String?
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInterface()
        fetchData(location: getLocation())
        
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
        
        icon.image = NSImage(named: "clear-day")
        
        // Sets background of view to orange
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bgColor.cgColor
        
        // Set button titles
        refresh.image = NSImage(named: "NSRefreshTemplate")
        unitControl.setLabel("ºC", forSegment: 0)
        unitControl.setLabel("ºF", forSegment: 1)
        
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
    func fetchData(location: String) {
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            guard let dataUrl = URL(string: location, relativeTo: self.baseUrl) else { print("Invalid URL Request"); return }
            
            guard let data = try? String(contentsOf: dataUrl) else {
                DispatchQueue.main.async {
                    print("Bad API call")
                }
                return
            }
            let newData = JSON(parseJSON: data)
            
            DispatchQueue.main.async {
                self.jsonFeed = newData
                //GET THIS DATA TO THE VIEWS
            }
        }
        
    }
    
    @IBAction func refreshClicked(_ sender: NSButton) {
        let loc = getLocation()
        print(loc)
        print("refresh Clicked")
    }
    
    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
    
}

