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
    
    typealias FetchWeatherDataCompletionHandler = (Weather?, Error?) -> Void
    typealias GetCurrentWeatherCompletionHandler = (CurrentWeather?, Error?) -> Void
    
    //MARK: CONNECT TO API AND RETRIEVE DATA
    /// Opens a URL session to retrieve the JSON feed from the DarkSky API. Constructs a URL using a string contaiing the latitude and logitude, as well as the units flag for C or Fº
    /// - Parameters:
    ///   - location: User's current location passed as a string concatenating the lat and long as "lat,long"
    ///   - units: An integer of 0, which denotes celcius, or 1, denoting F. Presently determined by userDefaults/segmented controller. Used to set the units flag on the API request
    ///   - completion: completion handler to pass parsed json data to whatever method is calling this function.
    func fetchData(at location: String, units: Int, completionHandler completion: @escaping FetchWeatherDataCompletionHandler ) {
        var symbol = ""
        if units == 0 {
            symbol = "?units=ca"
        } else {
            symbol = "?units=us"
        }
        print("****fetchData() called****\n")
        
        guard let dataUrl = URL(string: "\(location)\(symbol)", relativeTo: baseUrl) else {
            completion(nil, DarkSkyError.invalidURL)
            print("fetachData() failed to make dataUrl ")
            return
        }
        print("fetchData() dataUrl: \(dataUrl)\n")
        
        let request = URLRequest(url: dataUrl)
        
        let task = session.dataTask(with: request) { data, response, error in
            print("REQUEST", request)
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, DarkSkyError.requestFailed)
                        print("FAILED TO GET GOOD HTTPRESPONSE\n")
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let newData = try self.decoder.decode(Weather.self, from: data)
                            print("GOT NEW DATA!")
                            completion(newData, nil)
                        } catch let error {
                            print("DID NOT GET NEW DATA?")
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
    
    func getCurrentWeather(at location: String, units: Int, completionHandler completion: @escaping GetCurrentWeatherCompletionHandler) {
        print("getCurrentWeather() called!")
        fetchData(at: location, units: units) { weather, error in
            print("fetchData() called from within getCurrentWeather()")
            completion(weather?.currently, error)
        }
    }
}







