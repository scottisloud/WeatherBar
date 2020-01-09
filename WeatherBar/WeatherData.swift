//
//  CurrentWeather.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/2.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import Foundation
import AppKit

struct CurrentWeather: Codable {
    let temperature: Double
    let humidity: Double
    let precipProbability: Double
    let precipType: String
    let windSpeed: Double
    let summary: String
    let icon: String
}

extension CurrentWeather {
    var iconImage: NSImage {
        switch icon {
        case "clear-day": return #imageLiteral(resourceName: "clear-day")
        case "clear-night": return #imageLiteral(resourceName: "clear-night")
        case "rain": return #imageLiteral(resourceName: "rain")
        case "snow": return #imageLiteral(resourceName: "snow")
        case "sleet": return #imageLiteral(resourceName: "sleet")
        case "wind": return #imageLiteral(resourceName: "wind")
        case "fog": return #imageLiteral(resourceName: "fog")
        case "cloudy": return #imageLiteral(resourceName: "cloudy")
        case "partly-cloudy-day": return #imageLiteral(resourceName: "partly-cloudy-day")
        case "partly-cloudy-night": return #imageLiteral(resourceName: "partly-cloudy-night")
        default: return #imageLiteral(resourceName: "default")
        }
    }
}

// POTENTIAL STRUCT FOR DAILY WEATHER
//struct Daily: Codable {
//    struct Data: Codable {
//        let time: Int
//        let precipProbability: Double
//        let precipType: String
//        let temperatureHigh: Double
//        let temperatureLow: Double
//        let summary: String
//        let windSpeed: Double
//        let icon: String
//    }
//}
