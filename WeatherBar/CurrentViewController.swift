//
//  CurrentViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

// API Key: "960281f5a5cd1551f2f0446c79928e58"

import Cocoa
import CoreLocation

class CurrentViewController: NSViewController {
    
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
    
    let client = DarkSkyClient()
    let locationClient = Location()
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        let defaults = UserDefaults.standard
        let units = defaults.integer(forKey: "units")
        unitControl.selectedSegment = units
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current"
 
        updateData()
        setUpInterface()
        
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    //MARK: SET UP GENERAL APPEARANCE
    func setUpInterface() {
        displayLocationName()
        
        
        
        // Set Location Name Title
        
        titleLabel.stringValue = locationClient.locationName
        titleLabel.textColor = NSColor.textColor
        
        
        // Set button titles
        refresh.image = NSImage(named: "NSRefreshTemplate")
        unitControl.setLabel("ºC", forSegment: 0)
        unitControl.setLabel("ºF", forSegment: 1)
		precipLabel.textColor = NSColor.textColor
		humidityLabel.textColor = NSColor.textColor
		windSpeedLabel.textColor = NSColor.textColor
                
        // FIXME: Fix the DarkSky text looking strange when clicked
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
        displayLocationName()
        client.getCurrentWeather(at: locationClient.getLocation().locString, units: UserDefaults.standard.integer(forKey: "units")) { currentWeather, error in
            
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
                self.titleLabel.stringValue = placemark
            }
        }
    }
    
    func updateCurrentDisplay(using viewModel: CurrentWeatherViewModel) {
        temperature.stringValue = viewModel.temperature
        summary.stringValue = viewModel.summary
        precipValue.stringValue = viewModel.precipProb
        windSpeedValue.stringValue = viewModel.windSpeed
        humidityValue.stringValue = viewModel.humidity
        icon.image = viewModel.icon
        
    }
    
    @IBAction func selectUnits(_ sender: NSSegmentedControl) {
        UserDefaults.standard.set(unitControl.selectedSegment, forKey: "units")
        updateData()
        print("Selected Units Pressed")
    }
    
    @IBAction func refreshClicked(_ sender: NSButton) {
        
        updateData()
    }

    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
}


