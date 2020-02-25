//
//  WeatherViewModel.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/2.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import AppKit
import Foundation


struct CurrentWeatherViewModel {
	let temperature: String
	let humidity: String
	let precipProb: String
	let windSpeed: String
	let summary: String
	let icon: NSImage
	
	
	init(model: CurrentWeather) {
		
		let roundedTemperature = Int(model.temperature)
		
		let units = UserDefaults.standard.integer(forKey: "units")
		
		switch units {
		case 0:
			self.temperature = "\(roundedTemperature)ºC"
		case 1:
			self.temperature = "\(roundedTemperature)ºF"
		default:
			self.temperature = "\(roundedTemperature)ºC"
			
		}
		
		let humidityPercentValue = Int(model.humidity * 100)
		self.humidity = "\(humidityPercentValue)%"
		
		let precipitationPercentValue = Int(model.precipProbability * 100)
		self.precipProb = "\(precipitationPercentValue)%"
		
		let windSpeedValue = Int(model.windSpeed)
		
		switch units {
		case 0:
			self.windSpeed = "\(windSpeedValue) kph"
		case 1:
			self.windSpeed = "\(windSpeedValue) mph"
		default:
			self.windSpeed = "\(windSpeedValue) kph"
		}
		
		self.summary = model.summary
		
		self.icon = model.iconImage
		
	}
	
}

struct ForecastViewModel {
	let time: String
	let highTemp: String
	let lowTemp: String
	let humidity: String
	let precipProb: String
	let windSpeed: String
	let summary: String
	let icon: NSImage
	
	init (model: DailyWeather) {
			
		let units = UserDefaults.standard.integer(forKey: "units")
		
		
		//TODO: Finish the date parsing
		let date = Date(timeIntervalSince1970: model.time)
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE"
		let weekday = formatter.string(from: date)
		self.time = weekday
		
		
		let roundedHighTemp = Int(model.temperatureHigh)
		let roundedLowTemp = Int(model.temperatureLow)
		
		switch units {
		case 0:
			self.highTemp = "\(roundedHighTemp)ºC"
			self.lowTemp = "\(roundedLowTemp)ºC"
		case 1:
			self.highTemp = "\(roundedHighTemp)ºF"
			self.lowTemp = "\(roundedLowTemp)ºF"
		default:
			self.highTemp = "\(roundedHighTemp)ºC"
			self.lowTemp = "\(roundedLowTemp)ºC"
		}
		
		let humidityPercentValue = Int(model.humidity * 100)
		self.humidity = "\(humidityPercentValue)%"
		
		let precipitationPercentValue = Int(model.precipProbability * 100)
		self.precipProb = "\(precipitationPercentValue)%"
		
		let windSpeedValue = Int(model.windSpeed)
		
		switch units {
		case 0:
			self.windSpeed = "\(windSpeedValue) kph"
		case 1:
			self.windSpeed = "\(windSpeedValue) mph"
		default:
			self.windSpeed = "\(windSpeedValue) kph"
		}
		
		self.summary = model.summary
		
		self.icon = model.iconImage
	}
}
