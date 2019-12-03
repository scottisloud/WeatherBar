//
//  DarkSkyClient.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/2.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//
// lat/long of home: 40.435198, -86.907378

import Foundation
import AppKit


class DarkSkyClient {
    fileprivate let darkSkyApiKey = "960281f5a5cd1551f2f0446c79928e58"
    
    var baseUrl: URL {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }
    
    var jsonFeed: JSON?
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: .default)
    }
    
    func fetchData(at location: Location) {
        DispatchQueue.global(qos: .utility).async { [unowned self] in
                    
            guard let dataUrl = URL(string: location.locationString, relativeTo: self.baseUrl) else { print("Invalid URL Request"); return }
            
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
}







let testjson = """
{"latitude":40.435198,"longitude":-86.907378,"timezone":"America/Indiana/Indianapolis","currently":{"time":1575381555,"summary":"Overcast","icon":"cloudy","nearestStormDistance":2,"nearestStormBearing":141,"precipIntensity":0,"precipProbability":0,"temperature":30.45,"apparentTemperature":21.54,"dewPoint":27.99,"humidity":0.9,"pressure":1013.7,"windSpeed":10.5,"windGust":17.57,"windBearing":215,"cloudCover":0.91,"uvIndex":0,"visibility":10,"ozone":335.4},"minutely":{"summary":"Possible flurries starting in 55 min.","icon":"snow","data":[{"time":1575381540,"precipIntensity":0,"precipProbability":0},{"time":1575381600,"precipIntensity":0,"precipProbability":0},{"time":1575381660,"precipIntensity":0,"precipProbability":0},{"time":1575381720,"precipIntensity":0,"precipProbability":0},{"time":1575381780,"precipIntensity":0,"precipProbability":0},{"time":1575381840,"precipIntensity":0,"precipProbability":0},{"time":1575381900,"precipIntensity":0,"precipProbability":0},{"time":1575381960,"precipIntensity":0,"precipProbability":0},{"time":1575382020,"precipIntensity":0,"precipProbability":0},{"time":1575382080,"precipIntensity":0,"precipProbability":0},{"time":1575382140,"precipIntensity":0,"precipProbability":0},{"time":1575382200,"precipIntensity":0,"precipProbability":0},{"time":1575382260,"precipIntensity":0,"precipProbability":0},{"time":1575382320,"precipIntensity":0,"precipProbability":0},{"time":1575382380,"precipIntensity":0,"precipProbability":0},{"time":1575382440,"precipIntensity":0,"precipProbability":0},{"time":1575382500,"precipIntensity":0,"precipProbability":0},{"time":1575382560,"precipIntensity":0,"precipProbability":0},{"time":1575382620,"precipIntensity":0,"precipProbability":0},{"time":1575382680,"precipIntensity":0,"precipProbability":0},{"time":1575382740,"precipIntensity":0,"precipProbability":0},{"time":1575382800,"precipIntensity":0,"precipProbability":0},{"time":1575382860,"precipIntensity":0,"precipProbability":0},{"time":1575382920,"precipIntensity":0,"precipProbability":0},{"time":1575382980,"precipIntensity":0,"precipProbability":0},{"time":1575383040,"precipIntensity":0,"precipProbability":0},{"time":1575383100,"precipIntensity":0,"precipProbability":0},{"time":1575383160,"precipIntensity":0,"precipProbability":0},{"time":1575383220,"precipIntensity":0,"precipProbability":0},{"time":1575383280,"precipIntensity":0,"precipProbability":0},{"time":1575383340,"precipIntensity":0,"precipProbability":0},{"time":1575383400,"precipIntensity":0,"precipProbability":0},{"time":1575383460,"precipIntensity":0,"precipProbability":0},{"time":1575383520,"precipIntensity":0,"precipProbability":0},{"time":1575383580,"precipIntensity":0,"precipProbability":0},{"time":1575383640,"precipIntensity":0,"precipProbability":0},{"time":1575383700,"precipIntensity":0,"precipProbability":0},{"time":1575383760,"precipIntensity":0,"precipProbability":0},{"time":1575383820,"precipIntensity":0,"precipProbability":0},{"time":1575383880,"precipIntensity":0,"precipProbability":0},{"time":1575383940,"precipIntensity":0,"precipProbability":0},{"time":1575384000,"precipIntensity":0,"precipProbability":0},{"time":1575384060,"precipIntensity":0,"precipProbability":0},{"time":1575384120,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.01,"precipType":"snow"},{"time":1575384180,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.01,"precipType":"snow"},{"time":1575384240,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.02,"precipType":"snow"},{"time":1575384300,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.04,"precipType":"snow"},{"time":1575384360,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.06,"precipType":"snow"},{"time":1575384420,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.1,"precipType":"snow"},{"time":1575384480,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.14,"precipType":"snow"},{"time":1575384540,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.2,"precipType":"snow"},{"time":1575384600,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.25,"precipType":"snow"},{"time":1575384660,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.31,"precipType":"snow"},{"time":1575384720,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.38,"precipType":"snow"},{"time":1575384780,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.44,"precipType":"snow"},{"time":1575384840,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.48,"precipType":"snow"},{"time":1575384900,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.53,"precipType":"snow"},{"time":1575384960,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.56,"precipType":"snow"},{"time":1575385020,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.58,"precipType":"snow"},{"time":1575385080,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.59,"precipType":"snow"},{"time":1575385140,"precipIntensity":0.002,"precipIntensityError":0,"precipProbability":0.59,"precipType":"snow"}]},"hourly":{"summary":"Mostly cloudy throughout the day.","icon":"partly-cloudy-day","data":[{"time":1575378000,"summary":"Overcast","icon":"cloudy","precipIntensity":0,"precipProbability":0,"temperature":30.28,"apparentTemperature":22.08,"dewPoint":26.91,"humidity":0.87,"pressure":1014,"windSpeed":9.11,"windGust":15.93,"windBearing":222,"cloudCover":1,"uvIndex":0,"visibility":9.881,"ozone":333.3},{"time":1575381600,"summary":"Overcast","icon":"cloudy","precipIntensity":0.0001,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0015,"temperature":30.45,"apparentTemperature":21.54,"dewPoint":28,"humidity":0.9,"pressure":1013.7,"windSpeed":10.52,"windGust":17.59,"windBearing":215,"cloudCover":0.91,"uvIndex":0,"visibility":10,"ozone":335.5},{"time":1575385200,"summary":"Possible Flurries","icon":"snow","precipIntensity":0.0013,"precipProbability":0.59,"precipType":"snow","precipAccumulation":0.0129,"temperature":31.53,"apparentTemperature":22.15,"dewPoint":28.3,"humidity":0.88,"pressure":1012.9,"windSpeed":12.1,"windGust":18.5,"windBearing":209,"cloudCover":0.93,"uvIndex":1,"visibility":10,"ozone":338.1},{"time":1575388800,"summary":"Mostly Cloudy","icon":"partly-cloudy-day","precipIntensity":0,"precipProbability":0,"temperature":33.93,"apparentTemperature":24.26,"dewPoint":28.46,"humidity":0.8,"pressure":1011.9,"windSpeed":14.45,"windGust":22.88,"windBearing":212,"cloudCover":0.74,"uvIndex":1,"visibility":10,"ozone":341.7},{"time":1575392400,"summary":"Overcast","icon":"cloudy","precipIntensity":0.0006,"precipProbability":0.03,"precipType":"rain","temperature":36.17,"apparentTemperature":26.7,"dewPoint":29.25,"humidity":0.76,"pressure":1010.8,"windSpeed":15.7,"windGust":25.63,"windBearing":216,"cloudCover":0.93,"uvIndex":1,"visibility":10,"ozone":345.9},{"time":1575396000,"summary":"Overcast","icon":"cloudy","precipIntensity":0,"precipProbability":0,"temperature":38.45,"apparentTemperature":29.56,"dewPoint":30.52,"humidity":0.73,"pressure":1009.8,"windSpeed":15.93,"windGust":26.62,"windBearing":218,"cloudCover":1,"uvIndex":1,"visibility":10,"ozone":349.3},{"time":1575399600,"summary":"Overcast","icon":"cloudy","precipIntensity":0,"precipProbability":0,"temperature":40.13,"apparentTemperature":31.69,"dewPoint":31.25,"humidity":0.7,"pressure":1009,"windSpeed":16.03,"windGust":28.08,"windBearing":223,"cloudCover":1,"uvIndex":1,"visibility":10,"ozone":350.8},{"time":1575403200,"summary":"Overcast","icon":"cloudy","precipIntensity":0,"precipProbability":0,"temperature":41.5,"apparentTemperature":33.55,"dewPoint":31.01,"humidity":0.66,"pressure":1008,"windSpeed":15.68,"windGust":28.2,"windBearing":228,"cloudCover":0.92,"uvIndex":1,"visibility":10,"ozone":351.5},{"time":1575406800,"summary":"Mostly Cloudy","icon":"partly-cloudy-day","precipIntensity":0,"precipProbability":0,"temperature":41.51,"apparentTemperature":33.77,"dewPoint":30.39,"humidity":0.64,"pressure":1007.2,"windSpeed":15.01,"windGust":27.78,"windBearing":231,"cloudCover":0.76,"uvIndex":0,"visibility":10,"ozone":353.3},{"time":1575410400,"summary":"Partly Cloudy","icon":"partly-cloudy-day","precipIntensity":0,"precipProbability":0,"temperature":40.19,"apparentTemperature":32.45,"dewPoint":29.39,"humidity":0.65,"pressure":1006.7,"windSpeed":13.81,"windGust":27.1,"windBearing":233,"cloudCover":0.55,"uvIndex":0,"visibility":10,"ozone":358},{"time":1575414000,"summary":"Clear","icon":"clear-night","precipIntensity":0.0018,"precipProbability":0.02,"precipType":"rain","temperature":37.52,"apparentTemperature":29.52,"dewPoint":28.32,"humidity":0.69,"pressure":1006.7,"windSpeed":12.53,"windGust":23.28,"windBearing":231,"cloudCover":0.3,"uvIndex":0,"visibility":10,"ozone":363.7},{"time":1575417600,"summary":"Clear","icon":"clear-night","precipIntensity":0.0008,"precipProbability":0.02,"precipType":"rain","temperature":35.57,"apparentTemperature":27.3,"dewPoint":28.15,"humidity":0.74,"pressure":1006.7,"windSpeed":11.92,"windGust":23.46,"windBearing":232,"cloudCover":0.15,"uvIndex":0,"visibility":10,"ozone":366},{"time":1575421200,"summary":"Clear","icon":"clear-night","precipIntensity":0.0012,"precipProbability":0.02,"precipType":"rain","temperature":34.04,"apparentTemperature":25.69,"dewPoint":29.2,"humidity":0.82,"pressure":1006.6,"windSpeed":11.21,"windGust":22.83,"windBearing":239,"cloudCover":0.16,"uvIndex":0,"visibility":10,"ozone":361.7},{"time":1575424800,"summary":"Clear","icon":"clear-night","precipIntensity":0.0015,"precipProbability":0.02,"precipType":"rain","temperature":33.49,"apparentTemperature":25.13,"dewPoint":29.21,"humidity":0.84,"pressure":1006.2,"windSpeed":10.94,"windGust":22.58,"windBearing":244,"cloudCover":0.07,"uvIndex":0,"visibility":10,"ozone":354},{"time":1575428400,"summary":"Clear","icon":"clear-night","precipIntensity":0.0002,"precipProbability":0.02,"precipType":"rain","temperature":33.3,"apparentTemperature":25.04,"dewPoint":29.06,"humidity":0.84,"pressure":1006.4,"windSpeed":10.62,"windGust":21.99,"windBearing":245,"cloudCover":0.04,"uvIndex":0,"visibility":10,"ozone":347.4},{"time":1575432000,"summary":"Clear","icon":"clear-night","precipIntensity":0.0003,"precipProbability":0.02,"precipType":"rain","temperature":33.31,"apparentTemperature":24.84,"dewPoint":28.81,"humidity":0.83,"pressure":1006.8,"windSpeed":11.08,"windGust":25.31,"windBearing":244,"cloudCover":0.12,"uvIndex":0,"visibility":10,"ozone":343.6},{"time":1575435600,"summary":"Clear","icon":"clear-night","precipIntensity":0.0003,"precipProbability":0.02,"precipType":"rain","temperature":33.41,"apparentTemperature":24.88,"dewPoint":29.26,"humidity":0.85,"pressure":1006.6,"windSpeed":11.26,"windGust":25.35,"windBearing":271,"cloudCover":0.2,"uvIndex":0,"visibility":10,"ozone":340.8},{"time":1575439200,"summary":"Clear","icon":"clear-night","precipIntensity":0.0003,"precipProbability":0.01,"precipType":"rain","temperature":33.39,"apparentTemperature":24.74,"dewPoint":29.28,"humidity":0.85,"pressure":1006.5,"windSpeed":11.51,"windGust":25.3,"windBearing":262,"cloudCover":0.26,"uvIndex":0,"visibility":10,"ozone":338.3},{"time":1575442800,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":33.16,"apparentTemperature":24.33,"dewPoint":28.67,"humidity":0.83,"pressure":1006.3,"windSpeed":11.81,"windGust":24.86,"windBearing":243,"cloudCover":0.4,"uvIndex":0,"visibility":10,"ozone":335.6},{"time":1575446400,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":33,"apparentTemperature":23.97,"dewPoint":28.18,"humidity":0.82,"pressure":1006.3,"windSpeed":12.16,"windGust":24.24,"windBearing":287,"cloudCover":0.56,"uvIndex":0,"visibility":10,"ozone":332.9},{"time":1575450000,"summary":"Mostly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":32.69,"apparentTemperature":23.45,"dewPoint":27.7,"humidity":0.82,"pressure":1005.9,"windSpeed":12.47,"windGust":24,"windBearing":268,"cloudCover":0.66,"uvIndex":0,"visibility":10,"ozone":330.5},{"time":1575453600,"summary":"Mostly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":31.96,"apparentTemperature":22.51,"dewPoint":26.76,"humidity":0.81,"pressure":1006.2,"windSpeed":12.52,"windGust":24.36,"windBearing":269,"cloudCover":0.66,"uvIndex":0,"visibility":10,"ozone":328.4},{"time":1575457200,"summary":"Mostly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":31.23,"apparentTemperature":21.59,"dewPoint":25.65,"humidity":0.8,"pressure":1007.1,"windSpeed":12.51,"windGust":25.05,"windBearing":274,"cloudCover":0.62,"uvIndex":0,"visibility":10,"ozone":326.5},{"time":1575460800,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":31.13,"apparentTemperature":21.33,"dewPoint":25.3,"humidity":0.79,"pressure":1007.4,"windSpeed":12.82,"windGust":26.1,"windBearing":267,"cloudCover":0.58,"uvIndex":0,"visibility":10,"ozone":324.5},{"time":1575464400,"summary":"Partly Cloudy","icon":"partly-cloudy-day","precipIntensity":0,"precipProbability":0,"temperature":31.84,"apparentTemperature":21.85,"dewPoint":26.38,"humidity":0.8,"pressure":1007.8,"windSpeed":13.77,"windGust":28.01,"windBearing":221,"cloudCover":0.56,"uvIndex":0,"visibility":10,"ozone":322.5},{"time":1575468000,"summary":"Partly Cloudy","icon":"partly-cloudy-day","precipIntensity":0.0002,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0009,"temperature":33.09,"apparentTemperature":22.97,"dewPoint":27.83,"humidity":0.81,"pressure":1008.2,"windSpeed":15.06,"windGust":30.19,"windBearing":327,"cloudCover":0.54,"uvIndex":0,"visibility":10,"ozone":320.5},{"time":1575471600,"summary":"Partly Cloudy","icon":"partly-cloudy-day","precipIntensity":0.0002,"precipProbability":0.02,"precipType":"rain","temperature":34.77,"apparentTemperature":24.73,"dewPoint":28.96,"humidity":0.79,"pressure":1008.5,"windSpeed":16.24,"windGust":31.29,"windBearing":279,"cloudCover":0.53,"uvIndex":1,"visibility":10,"ozone":318.2},{"time":1575475200,"summary":"Partly Cloudy","icon":"partly-cloudy-day","precipIntensity":0,"precipProbability":0,"temperature":37.17,"apparentTemperature":27.53,"dewPoint":30.57,"humidity":0.77,"pressure":1008.6,"windSpeed":17.2,"windGust":30.86,"windBearing":276,"cloudCover":0.45,"uvIndex":1,"visibility":10,"ozone":315.5},{"time":1575478800,"summary":"Partly Cloudy","icon":"partly-cloudy-day","precipIntensity":0,"precipProbability":0,"temperature":39.69,"apparentTemperature":30.57,"dewPoint":32.36,"humidity":0.75,"pressure":1008.6,"windSpeed":18.04,"windGust":29.55,"windBearing":281,"cloudCover":0.34,"uvIndex":2,"visibility":10,"ozone":312.4},{"time":1575482400,"summary":"Clear","icon":"clear-day","precipIntensity":0,"precipProbability":0,"temperature":42,"apparentTemperature":33.47,"dewPoint":33.89,"humidity":0.73,"pressure":1008.8,"windSpeed":18.45,"windGust":28.03,"windBearing":288,"cloudCover":0.25,"uvIndex":2,"visibility":10,"ozone":309.8},{"time":1575486000,"summary":"Clear","icon":"clear-day","precipIntensity":0,"precipProbability":0,"temperature":43.32,"apparentTemperature":35.22,"dewPoint":34.84,"humidity":0.72,"pressure":1009.2,"windSpeed":18.34,"windGust":26.21,"windBearing":289,"cloudCover":0.19,"uvIndex":1,"visibility":10,"ozone":307.6},{"time":1575489600,"summary":"Clear","icon":"clear-day","precipIntensity":0,"precipProbability":0,"temperature":44.22,"apparentTemperature":36.51,"dewPoint":34.5,"humidity":0.68,"pressure":1009.8,"windSpeed":17.81,"windGust":24.18,"windBearing":290,"cloudCover":0.14,"uvIndex":1,"visibility":10,"ozone":305.8},{"time":1575493200,"summary":"Clear","icon":"clear-day","precipIntensity":0,"precipProbability":0,"temperature":44.03,"apparentTemperature":36.51,"dewPoint":32.86,"humidity":0.65,"pressure":1010.2,"windSpeed":16.86,"windGust":22.89,"windBearing":290,"cloudCover":0.11,"uvIndex":0,"visibility":10,"ozone":304.7},{"time":1575496800,"summary":"Clear","icon":"clear-day","precipIntensity":0,"precipProbability":0,"temperature":42.46,"apparentTemperature":34.9,"dewPoint":31.83,"humidity":0.66,"pressure":1011.1,"windSpeed":15.32,"windGust":23.04,"windBearing":290,"cloudCover":0.15,"uvIndex":0,"visibility":10,"ozone":304.3},{"time":1575500400,"summary":"Clear","icon":"clear-night","precipIntensity":0,"precipProbability":0,"temperature":39.74,"apparentTemperature":32.03,"dewPoint":30.84,"humidity":0.7,"pressure":1012.2,"windSpeed":13.38,"windGust":23.86,"windBearing":289,"cloudCover":0.22,"uvIndex":0,"visibility":10,"ozone":304.7},{"time":1575504000,"summary":"Clear","icon":"clear-night","precipIntensity":0,"precipProbability":0,"temperature":37.68,"apparentTemperature":30.04,"dewPoint":30.77,"humidity":0.76,"pressure":1013.1,"windSpeed":11.71,"windGust":23.87,"windBearing":288,"cloudCover":0.27,"uvIndex":0,"visibility":10,"ozone":305.8},{"time":1575507600,"summary":"Clear","icon":"clear-night","precipIntensity":0,"precipProbability":0,"temperature":35.76,"apparentTemperature":28.09,"dewPoint":30.47,"humidity":0.81,"pressure":1013.7,"windSpeed":10.65,"windGust":22.5,"windBearing":286,"cloudCover":0.29,"uvIndex":0,"visibility":10,"ozone":308.2},{"time":1575511200,"summary":"Clear","icon":"clear-night","precipIntensity":0.0003,"precipProbability":0.01,"precipType":"rain","temperature":34.53,"apparentTemperature":26.96,"dewPoint":30,"humidity":0.83,"pressure":1014.3,"windSpeed":9.82,"windGust":20.37,"windBearing":284,"cloudCover":0.3,"uvIndex":0,"visibility":10,"ozone":311.2},{"time":1575514800,"summary":"Clear","icon":"clear-night","precipIntensity":0.0004,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0017,"temperature":33.6,"apparentTemperature":26.29,"dewPoint":29.49,"humidity":0.85,"pressure":1014.8,"windSpeed":8.88,"windGust":17.72,"windBearing":290,"cloudCover":0.31,"uvIndex":0,"visibility":10,"ozone":313.5},{"time":1575518400,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0.0002,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.001,"temperature":32.69,"apparentTemperature":25.96,"dewPoint":28.75,"humidity":0.85,"pressure":1015.4,"windSpeed":7.54,"windGust":14.29,"windBearing":302,"cloudCover":0.32,"uvIndex":0,"visibility":10,"ozone":313.9},{"time":1575522000,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":31.13,"apparentTemperature":25.11,"dewPoint":28.48,"humidity":0.9,"pressure":1016,"windSpeed":6.11,"windGust":10.52,"windBearing":249,"cloudCover":0.33,"uvIndex":0,"visibility":10,"ozone":313.5},{"time":1575525600,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":29.97,"apparentTemperature":24.61,"dewPoint":28.03,"humidity":0.92,"pressure":1016,"windSpeed":5.09,"windGust":7.85,"windBearing":284,"cloudCover":0.34,"uvIndex":0,"visibility":10,"ozone":313.9},{"time":1575529200,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":29.19,"apparentTemperature":23.96,"dewPoint":26.97,"humidity":0.91,"pressure":1016.3,"windSpeed":4.81,"windGust":6.91,"windBearing":0,"cloudCover":0.34,"uvIndex":0,"visibility":10,"ozone":315.9},{"time":1575532800,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0,"precipProbability":0,"temperature":28.58,"apparentTemperature":23.1,"dewPoint":25.8,"humidity":0.89,"pressure":1016.7,"windSpeed":4.96,"windGust":6.93,"windBearing":178,"cloudCover":0.34,"uvIndex":0,"visibility":10,"ozone":318.5},{"time":1575536400,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0.0002,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0015,"temperature":27.9,"apparentTemperature":22.17,"dewPoint":24.91,"humidity":0.88,"pressure":1016.9,"windSpeed":5.09,"windGust":7.06,"windBearing":240,"cloudCover":0.34,"uvIndex":0,"visibility":10,"ozone":321},{"time":1575540000,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0.0002,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0016,"temperature":27.16,"apparentTemperature":21.37,"dewPoint":24.15,"humidity":0.88,"pressure":1017.3,"windSpeed":5.02,"windGust":6.84,"windBearing":249,"cloudCover":0.43,"uvIndex":0,"visibility":10,"ozone":322.7},{"time":1575543600,"summary":"Partly Cloudy","icon":"partly-cloudy-night","precipIntensity":0.0002,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0017,"temperature":26.85,"apparentTemperature":21.1,"dewPoint":23.73,"humidity":0.88,"pressure":1017.7,"windSpeed":4.93,"windGust":6.75,"windBearing":231,"cloudCover":0.56,"uvIndex":0,"visibility":9.39,"ozone":324.1},{"time":1575547200,"summary":"Mostly Cloudy","icon":"partly-cloudy-night","precipIntensity":0.0002,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0017,"temperature":27.12,"apparentTemperature":21.22,"dewPoint":24.07,"humidity":0.88,"pressure":1018.1,"windSpeed":5.12,"windGust":7.32,"windBearing":215,"cloudCover":0.65,"uvIndex":0,"visibility":7.258,"ozone":325.4},{"time":1575550800,"summary":"Mostly Cloudy","icon":"partly-cloudy-night","precipIntensity":0.0002,"precipProbability":0.01,"precipType":"snow","precipAccumulation":0.0019,"temperature":27.77,"apparentTemperature":21.37,"dewPoint":25.13,"humidity":0.9,"pressure":1018.3,"windSpeed":5.79,"windGust":9.07,"windBearing":210,"cloudCover":0.66,"uvIndex":0,"visibility":7.126,"ozone":326.5}]},"daily":{"summary":"Mixed precipitation on Sunday through next Tuesday.","icon":"sleet","data":[{"time":1575349200,"summary":"Overcast throughout the day.","icon":"cloudy","sunriseTime":1575377700,"sunsetTime":1575411780,"moonPhase":0.24,"precipIntensity":0.0004,"precipIntensityMax":0.0018,"precipIntensityMaxTime":1575414240,"precipProbability":0.13,"precipType":"snow","precipAccumulation":0.02,"temperatureHigh":42.17,"temperatureHighTime":1575405060,"temperatureLow":30.59,"temperatureLowTime":1575459600,"apparentTemperatureHigh":33.87,"apparentTemperatureHighTime":1575405480,"apparentTemperatureLow":21.32,"apparentTemperatureLowTime":1575460260,"dewPoint":28.46,"humidity":0.81,"pressure":1011.1,"windSpeed":11.18,"windGust":28.26,"windGustTime":1575401460,"windBearing":230,"cloudCover":0.72,"uvIndex":1,"uvIndexTime":1575394140,"visibility":9.904,"ozone":344.6,"temperatureMin":29.41,"temperatureMinTime":1575369780,"temperatureMax":42.17,"temperatureMaxTime":1575405060,"apparentTemperatureMin":20.46,"apparentTemperatureMinTime":1575370860,"apparentTemperatureMax":33.87,"apparentTemperatureMaxTime":1575405480},{"time":1575435600,"summary":"Partly cloudy throughout the day.","icon":"partly-cloudy-day","sunriseTime":1575464160,"sunsetTime":1575498180,"moonPhase":0.27,"precipIntensity":0.0001,"precipIntensityMax":0.0004,"precipIntensityMaxTime":1575514680,"precipProbability":0.14,"precipType":"rain","temperatureHigh":44.79,"temperatureHighTime":1575490920,"temperatureLow":26.35,"temperatureLowTime":1575543720,"apparentTemperatureHigh":36.69,"apparentTemperatureHighTime":1575491460,"apparentTemperatureLow":21.09,"apparentTemperatureLowTime":1575544020,"dewPoint":29.78,"humidity":0.78,"pressure":1009.6,"windSpeed":13.49,"windGust":31.32,"windGustTime":1575472200,"windBearing":280,"cloudCover":0.37,"uvIndex":2,"uvIndexTime":1575481560,"visibility":10,"ozone":317.6,"temperatureMin":30.59,"temperatureMinTime":1575459600,"temperatureMax":44.79,"temperatureMaxTime":1575490920,"apparentTemperatureMin":21.32,"apparentTemperatureMinTime":1575460260,"apparentTemperatureMax":36.69,"apparentTemperatureMaxTime":1575491460},{"time":1575522000,"summary":"Partly cloudy throughout the day.","icon":"partly-cloudy-day","sunriseTime":1575550620,"sunsetTime":1575584580,"moonPhase":0.3,"precipIntensity":0.0002,"precipIntensityMax":0.0017,"precipIntensityMaxTime":1575608400,"precipProbability":0.1,"precipType":"snow","precipAccumulation":0.02,"temperatureHigh":49.89,"temperatureHighTime":1575577380,"temperatureLow":30.69,"temperatureLowTime":1575633840,"apparentTemperatureHigh":45.14,"apparentTemperatureHighTime":1575577680,"apparentTemperatureLow":22.61,"apparentTemperatureLowTime":1575636420,"dewPoint":31.99,"humidity":0.85,"pressure":1017.2,"windSpeed":7.71,"windGust":17.99,"windGustTime":1575572640,"windBearing":227,"cloudCover":0.54,"uvIndex":2,"uvIndexTime":1575567720,"visibility":9.472,"ozone":327.2,"temperatureMin":26.35,"temperatureMinTime":1575543720,"temperatureMax":49.89,"temperatureMaxTime":1575577380,"apparentTemperatureMin":21.09,"apparentTemperatureMinTime":1575544020,"apparentTemperatureMax":45.14,"apparentTemperatureMaxTime":1575577680},{"time":1575608400,"summary":"Partly cloudy throughout the day.","icon":"partly-cloudy-day","sunriseTime":1575637080,"sunsetTime":1575670920,"moonPhase":0.33,"precipIntensity":0.0005,"precipIntensityMax":0.0029,"precipIntensityMaxTime":1575612300,"precipProbability":0.14,"precipType":"rain","temperatureHigh":40.13,"temperatureHighTime":1575659040,"temperatureLow":18.2,"temperatureLowTime":1575715740,"apparentTemperatureHigh":32.48,"apparentTemperatureHighTime":1575658980,"apparentTemperatureLow":11.74,"apparentTemperatureLowTime":1575719100,"dewPoint":25.66,"humidity":0.75,"pressure":1028.4,"windSpeed":9.18,"windGust":22.55,"windGustTime":1575639840,"windBearing":342,"cloudCover":0.39,"uvIndex":2,"uvIndexTime":1575654120,"visibility":10,"ozone":338.8,"temperatureMin":21.97,"temperatureMinTime":1575694800,"temperatureMax":40.13,"temperatureMaxTime":1575659040,"apparentTemperatureMin":20.41,"apparentTemperatureMinTime":1575686880,"apparentTemperatureMax":32.48,"apparentTemperatureMaxTime":1575658980},{"time":1575694800,"summary":"Clear throughout the day.","icon":"clear-day","sunriseTime":1575723540,"sunsetTime":1575757320,"moonPhase":0.37,"precipIntensity":0.0001,"precipIntensityMax":0.0003,"precipIntensityMaxTime":1575750900,"precipProbability":0.12,"precipType":"snow","precipAccumulation":0.02,"temperatureHigh":44.55,"temperatureHighTime":1575750720,"temperatureLow":32.69,"temperatureLowTime":1575778320,"apparentTemperatureHigh":38.12,"apparentTemperatureHighTime":1575750960,"apparentTemperatureLow":23.49,"apparentTemperatureLowTime":1575778560,"dewPoint":20.58,"humidity":0.67,"pressure":1030.1,"windSpeed":8.5,"windGust":33.26,"windGustTime":1575781200,"windBearing":177,"cloudCover":0.05,"uvIndex":2,"uvIndexTime":1575740520,"visibility":10,"ozone":335.3,"temperatureMin":18.2,"temperatureMinTime":1575715740,"temperatureMax":44.55,"temperatureMaxTime":1575750720,"apparentTemperatureMin":11.74,"apparentTemperatureMinTime":1575719100,"apparentTemperatureMax":38.12,"apparentTemperatureMaxTime":1575750960},{"time":1575781200,"summary":"Drizzle in the evening and overnight.","icon":"rain","sunriseTime":1575810000,"sunsetTime":1575843720,"moonPhase":0.4,"precipIntensity":0.003,"precipIntensityMax":0.009,"precipIntensityMaxTime":1575849360,"precipProbability":0.74,"precipType":"rain","temperatureHigh":48.39,"temperatureHighTime":1575832140,"temperatureLow":44.27,"temperatureLowTime":1575889440,"apparentTemperatureHigh":41.02,"apparentTemperatureHighTime":1575846660,"apparentTemperatureLow":40.95,"apparentTemperatureLowTime":1575849600,"dewPoint":38.86,"humidity":0.87,"pressure":1015.3,"windSpeed":16.13,"windGust":37.75,"windGustTime":1575816300,"windBearing":200,"cloudCover":0.8,"uvIndex":1,"uvIndexTime":1575826800,"visibility":10,"ozone":329.1,"temperatureMin":32.87,"temperatureMinTime":1575781200,"temperatureMax":48.39,"temperatureMaxTime":1575832140,"apparentTemperatureMin":23.67,"apparentTemperatureMinTime":1575781200,"apparentTemperatureMax":41.81,"apparentTemperatureMaxTime":1575863280},{"time":1575867600,"summary":"Possible drizzle in the morning and overnight.","icon":"rain","sunriseTime":1575896400,"sunsetTime":1575930120,"moonPhase":0.43,"precipIntensity":0.0025,"precipIntensityMax":0.0085,"precipIntensityMaxTime":1575871500,"precipProbability":0.85,"precipType":"rain","temperatureHigh":54.38,"temperatureHighTime":1575922860,"temperatureLow":32.05,"temperatureLowTime":1575982800,"apparentTemperatureHigh":53.88,"apparentTemperatureHighTime":1575922860,"apparentTemperatureLow":22.83,"apparentTemperatureLowTime":1575982800,"dewPoint":48.34,"humidity":1,"pressure":1008.5,"windSpeed":6.23,"windGust":23.95,"windGustTime":1575867600,"windBearing":191,"cloudCover":1,"uvIndex":1,"uvIndexTime":1575913320,"visibility":9.621,"ozone":333.6,"temperatureMin":43.79,"temperatureMinTime":1575954000,"temperatureMax":54.38,"temperatureMaxTime":1575922860,"apparentTemperatureMin":39.7,"apparentTemperatureMinTime":1575954000,"apparentTemperatureMax":53.88,"apparentTemperatureMaxTime":1575922860},{"time":1575954000,"summary":"Light snow in the morning and afternoon.","icon":"snow","sunriseTime":1575982860,"sunsetTime":1576016520,"moonPhase":0.46,"precipIntensity":0.0077,"precipIntensityMax":0.0243,"precipIntensityMaxTime":1576000560,"precipProbability":0.95,"precipType":"snow","precipAccumulation":1.34,"temperatureHigh":34.23,"temperatureHighTime":1575979200,"temperatureLow":12.02,"temperatureLowTime":1576064220,"apparentTemperatureHigh":24.92,"apparentTemperatureHighTime":1575979200,"apparentTemperatureLow":1.94,"apparentTemperatureLowTime":1576064640,"dewPoint":27.21,"humidity":0.88,"pressure":1012.3,"windSpeed":12.84,"windGust":28.64,"windGustTime":1575999960,"windBearing":300,"cloudCover":1,"uvIndex":1,"uvIndexTime":1575999600,"visibility":6.962,"ozone":345.7,"temperatureMin":18.35,"temperatureMinTime":1576040400,"temperatureMax":44.78,"temperatureMaxTime":1575954000,"apparentTemperatureMin":7.01,"apparentTemperatureMinTime":1576040400,"apparentTemperatureMax":39.7,"apparentTemperatureMaxTime":1575954000}]},"flags":{"sources":["nwspa","cmc","gfs","hrrr","icon","isd","madis","nam","sref","darksky","nearest-precip"],"nearest-station":2.237,"units":"us"},"offset":-5}
""".data(using: .utf8)!
