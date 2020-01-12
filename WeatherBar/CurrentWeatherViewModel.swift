//
//  CurrentWeatherViewModel.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/2.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import Foundation
import AppKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipProb: String
    let windSpeed: String
    let summary: String
    let icon: NSImage
    
    
    init(model: CurrentWeather) {
        
        var displayUnits = "C"
        let roundedTemperature = Int(model.temperature)
        let defaults = UserDefaults.standard
        let units = defaults.integer(forKey: "units")
        if units == 1 {
            displayUnits = "F"
        }
        self.temperature = "\(roundedTemperature)º \(displayUnits)"
        
        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"
        
        let precipitationPercentValue = Int(model.precipProbability * 100)
        self.precipProb = "\(precipitationPercentValue)%"
        
        let windSpeedValue = Int(model.windSpeed)
        self.windSpeed = "\(windSpeedValue)"
        
        self.summary = model.summary
        
        self.icon = model.iconImage
        
    }
}
