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
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: .default)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //MARK: CONNECT TO API AND RETRIEVE DATA
    func fetchData(location: String, units: Int, completionHandler completion: @escaping (Weather?, Error?) -> Void) {
        var symbol = ""
        if units == 0 {
            symbol = "?units=ca"
        } else {
            symbol = "?units=us"
        }
        
        print("FETCH DATA CALLED")
        
        guard let dataUrl = URL(string: "\(location)\(symbol)", relativeTo: self.baseUrl) else {
            completion(nil, DarkSkyError.invalidURL)
            print("FAILED TO MAKE DATAURL")
            return
        }
        print("GUARD LET DATAURL \(dataUrl)")
        let request = URLRequest(url: dataUrl)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, DarkSkyError.requestFailed)
                        print("FAILED TO GET GOOD HTTPRESPONSE")
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let newData = try self.decoder.decode(Weather.self, from: data)
                            print("GOT NEW DATA!")
                            completion(newData, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, DarkSkyError.responseUnsuccessful(statusCode: httpResponse.statusCode))
                        return
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func getCurrentWeather(at location: Location, units: Int, completionHandler completion: @escaping (CurrentWeather?, Error?) -> Void) {
        print("getCurrentWeather() called!")
        fetchData(location: location.coordString, units: units) { weather, error in
            print("fetchData() called from within getCurrentWeather()")
            completion(weather?.currently, error)
        }
    }
}







