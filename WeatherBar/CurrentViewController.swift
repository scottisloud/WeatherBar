//
//  CurrentViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

// API Key: "960281f5a5cd1551f2f0446c79928e58"

import AppKit
import CoreLocation

class CurrentViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
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
    
	@IBOutlet var forecastTable: NSTableView!
	
	
	let client = DarkSkyClient()
    let locationClient = Location()
	var units = UserDefaults.standard.integer(forKey: "units")
	var dailyData: DailyData?
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
		
        client.getDailyWeather(at: locationClient.getLocation().locString, units: units) { dailyData, error in
            if let dailyData = dailyData {
                self.dailyData = dailyData
                print("data assignment succeeded")
                self.forecastTable.reloadData()
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
    
	func numberOfRows(in tableView: NSTableView) -> Int {
			if let data = dailyData?.data {

				print("got number of rows!")
				return data.count
			} else {
				print("problem getting number of rows")
				return 0
			}
		}
		
	//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
	//        guard let data = dailyData?.data[row].summary else { return "error" }
	//        print(data)
	//        return data
	//    }
		
		func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
			guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }

			if let summary = dailyData?.data[row].summary {
				print(summary)
				print("assigning summary success!")
				vw.textField?.stringValue = summary
			}
			return vw
		}
    
    
    @IBAction func refreshClicked(_ sender: Any) {
        updateData()
    }
    
    
}


