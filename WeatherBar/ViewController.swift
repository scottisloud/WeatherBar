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

class ViewController: NSViewController {
    
    // MARK: Interface-related constants
    @IBOutlet weak var icon: NSImageView!
    @IBOutlet weak var temperature: NSTextField!
    @IBOutlet weak var summary: NSTextField!
    @IBOutlet weak var precipValue: NSTextField!
    @IBOutlet weak var precipLabel: NSTextField!
    @IBOutlet weak var humidityValue: NSTextField!
    @IBOutlet weak var humidityLabel: NSTextField!
    @IBOutlet weak var windSpeedValue: NSTextField!
    @IBOutlet weak var windSpeedLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var unitControl: NSSegmentedControl!
    @IBOutlet weak var refresh: NSButton!
    @IBOutlet weak var quit: NSButton!
    @IBOutlet weak var darkSkyLink: NSTextField!
    
//    let bgColor = NSColor.systemGray
    
    var units: Int = 0
    
    // MARK: API-related objects
    fileprivate let darkSkyApiKey = "960281f5a5cd1551f2f0446c79928e58"
    var baseUrl: URL {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }
    
    let client = DarkSkyClient()
    let locationClient = Location()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        units = defaults.integer(forKey: "units")
        unitControl.selectedSegment = units
        updateData()
        setUpInterface()
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    //MARK: SET UP GENERAL APPEARANCE
    func setUpInterface() {

        displayLocationName()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Set Location Name Title
        
        titleLabel.stringValue = locationClient.locationName
        titleLabel.textColor = NSColor.textColor
        print("LOCATION NAME: ", locationClient.locationName)
        
        // Sets background color
//        self.view.wantsLayer = true

        
        // Set button titles
        refresh.image = NSImage(named: "NSRefreshTemplate")
        unitControl.setLabel("ºC", forSegment: 0)
        unitControl.setLabel("ºF", forSegment: 1)
		precipLabel.textColor = NSColor.textColor
		humidityLabel.textColor = NSColor.textColor
		windSpeedLabel.textColor = NSColor.textColor
        
        
        // TODO: Fix the DarkSky text looking strange when clicked
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: NSColor.linkColor,
            NSAttributedString.Key.link: NSURL(string: "https://darksky.net/poweredby/")!
        ]
        
        let darkSkyAttributedString = NSMutableAttributedString(string: "Powered by DarkSky", attributes: attributes)
        darkSkyLink.isSelectable = true
        darkSkyLink.allowsEditingTextAttributes = true
        darkSkyLink.attributedStringValue = darkSkyAttributedString
        
        quit.title = "Quit"
    }
    
    
    func updateData() {
        print("updateData() called")

        client.getCurrentWeather(at: locationClient.getLocation().locString, units: units) { currentWeather, error in
            
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherViewModel(model: currentWeather)
                self.updateCurrentDisplay(using: viewModel)
            }
        }
    }
    
    func displayLocationName() {
        print("displayLocationName() called")
        locationClient.getLocationName(){ placemark, error in
            if let placemark = placemark {
                print(placemark)
                self.titleLabel.stringValue = placemark
            }
        }
    }
    
    func updateCurrentDisplay(using viewModel: CurrentWeatherViewModel) {
        print("updateCurrentDisplay() called")
        temperature.stringValue = viewModel.temperature
        summary.stringValue = viewModel.summary
        precipValue.stringValue = viewModel.precipProb
        windSpeedValue.stringValue = viewModel.windSpeed
        humidityValue.stringValue = viewModel.humidity
        icon.image = viewModel.icon
        
    }
    
    @IBAction func selectUnits(_ sender: NSSegmentedControl) {
        let defaults = UserDefaults.standard
        defaults.set(unitControl.selectedSegment, forKey: "units")
        updateData()
    }
    
    @IBAction func refreshClicked(_ sender: NSButton) {
        updateData()
    }
    
    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
}

