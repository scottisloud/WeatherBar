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
    func fetchData(location: String, units: Int) {
        
        
        
// LIKELY OUTDATED CODE TO BE DELETED
//        DispatchQueue.global(qos: .utility).async { [unowned self] in
//            var symbol = ""
//            if units == 0 {
//                symbol = "?units=ca"
//            } else {
//                symbol = "?units=us"
//            }
//
//            guard let dataUrl = URL(string: "\(location)\(symbol)", relativeTo: self.baseUrl) else { print("Invalid URL Request"); return }
//
//            print(dataUrl)
//
//            guard let data = try? String(contentsOf: dataUrl) else {
//                DispatchQueue.main.async {
//                    print("Bad API call")
//                }
//
//                return
//            }
//
//            let newData = JSON(parseJSON: data)
//
//            DispatchQueue.main.async {
//                self.jsonFeed = newData
//                self.updateDisplay()
//            }
//        }
    }
}







