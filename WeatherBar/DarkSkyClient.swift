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

    func fetchData(at location: Location) {
        DispatchQueue.global(qos: .utility).async { [unowned self] in

			guard let dataUrl = URL(string: location.coordString, relativeTo: self.baseUrl) else { print("Invalid URL Request"); return }

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







