//
//  ForecastViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2020/01/15.
//  Copyright © 2020 Scott Lougheed. All rights reserved.
//
import AppKit
import Foundation



class ForecastViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    let client = DarkSkyClient()
    let locationClient = Location()
    var userLocation: (Double, Double, String)?
    var units = UserDefaults.standard.integer(forKey: "units")
    var dailyData: DailyData?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        print("VIEW WILL APPEAR")
        updateData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forecast"
        print("VIEW DID LOAD")
        updateData()
        
        print(dailyData)
    }
    
    
    func updateData() {
        client.getDailyWeather(at: locationClient.getLocation().locString, units: units) { dailyData, error in
            if let dailyData = dailyData {
                self.dailyData = dailyData
                for day in dailyData.data {
                    print(day.summary, "\n")
                }
            }
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if let data = dailyData?.data {

            
            return data.count
        } else {
            print("problem getting number of rows")
            return 0
        }
    }
}
