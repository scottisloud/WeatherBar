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
	
	// MARK: INTERFACE-RELATED CONSTANTS
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
	
	// MARK: - DATA-RELATED CONSTANTS
	let client = DarkSkyClient()
	let locationClient = Location()
	var units = UserDefaults.standard.integer(forKey: "units")
	var dailyData: DailyData?
	var userLocation: (Double, Double, String)?
	
	override func viewWillAppear() {
		
		super.viewWillAppear()
		if units != UserDefaults.standard.integer(forKey: "units") {
			units = UserDefaults.standard.integer(forKey: "units")
		}
		
		// TODO: - Write conditional (using notificaitons?) to ensure that this only fetches new data if the settings have changed, or only if coming from the SettingsViewController (whichever is easier to implement).
		
		updateData()
		forecastTable.reloadData()
	}
	
	// MARK: - viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Current"
		
		updateData()
		setUpInterface()
		forecastTable.reloadData()
	}
	
	override func viewWillDisappear() {
		super.viewWillDisappear()
	}
	
	//MARK: - SET UP GENERAL APPEARANCE
	func setUpInterface() {
		displayLocationName()
		
		// Set Location Name Title
		titleLabel.stringValue = locationClient.locationName
		titleLabel.textColor = NSColor.textColor
		
		// Set label colors
		precipLabel.textColor = NSColor.textColor
		humidityLabel.textColor = NSColor.textColor
		windSpeedLabel.textColor = NSColor.textColor
		
		forecastTable.reloadData()
		
	}
	
	// MARK: - RETREIVE DATA
	func updateData() {
		displayLocationName()
		
		client.getCurrentWeather(at: locationClient.getLocation().locString, units: units) { currentWeather, error in
			if let currentWeather = currentWeather {
				let viewModel = CurrentWeatherViewModel(model: currentWeather)
				self.updateCurrentDisplay(using: viewModel)
			}
		}
		
		client.getDailyWeather(at: locationClient.getLocation().locString, units: units) { dailyData, error in
			if let unwrappedDailyData = dailyData {
				self.dailyData = unwrappedDailyData
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
	
	// MARK: - TABLEVIEW DELEGATE
	func numberOfRows(in tableView: NSTableView) -> Int {
		if let data = dailyData?.data { return data.count } else { return 0 }
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard let forecastCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "forecastTableCell"), owner: self) as? ForecastTableCell else { return nil }

		if let unwrappedDailyData = dailyData {
			let viewModel = ForecastViewModel(model: unwrappedDailyData.data[row])
			forecastCell.forecastCellIcon.image = viewModel.icon
			forecastCell.weekdayLabel.stringValue = viewModel.time
			forecastCell.forecastCellSummaryLabel.stringValue = "\(viewModel.summary)"
			forecastCell.highTempValue.stringValue = viewModel.highTemp
			forecastCell.lowTempVlue.stringValue = viewModel.lowTemp
			forecastCell.windSpeedValue.stringValue = viewModel.windSpeed
			forecastCell.precipValue.stringValue = viewModel.precipProb
		}

		return forecastCell
	}
}


