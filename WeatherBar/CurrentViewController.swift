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
    @IBOutlet weak var highLabel: NSTextField!
    @IBOutlet weak var lowLabel: NSTextField!
    @IBOutlet weak var summary: NSTextField!
    @IBOutlet weak var precipValue: NSTextField!
    @IBOutlet weak var precipLabel: NSTextField!
    @IBOutlet weak var humidityValue: NSTextField!
    @IBOutlet weak var humidityLabel: NSTextField!
    @IBOutlet weak var windSpeedValue: NSTextField!
    @IBOutlet weak var windSpeedLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    
    let client = DarkSkyClient()
    let locationClient = Location()
    var userLocation: (Double, Double, String)?
    
    override func viewWillAppear() {
        
        super.viewWillAppear()
        // TODO: - Write conditional (using notificaitons?) to ensure that this only fetches new data if the settings have changed, or only if coming from the SettingsViewController (whichever is easier to implement).
        updateData()

    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Current"
        
        updateData()
        setUpInterface()
        print(UserDefaults.standard.integer(forKey: "units"))
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
//        refresh.image = NSImage(named: "NSRefreshTemplate")
        
        precipLabel.textColor = NSColor.textColor
        humidityLabel.textColor = NSColor.textColor
        windSpeedLabel.textColor = NSColor.textColor
        
        //FIXME: TEMPORARY VALUES HERE. Need to connect to Daily data in WeatherData.swift.
        highLabel.stringValue = "High: 100º"
        lowLabel.stringValue = "Low: -19º"
        
        
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
        
        print(UserDefaults.standard.integer(forKey: "units"))
    }
    
    
    
    @IBAction func refreshClicked(_ sender: Any) {
        updateData()
    }
    
    
}


