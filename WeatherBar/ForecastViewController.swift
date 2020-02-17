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
    
    @IBOutlet var forecastTable: NSTableView!
    
    
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
        forecastTable.reloadData()
    }
    
    
    func updateData() {
        client.getDailyWeather(at: locationClient.getLocation().locString, units: units) { dailyData, error in
            if let dailyData = dailyData {
                self.dailyData = dailyData
                print("data assignment succeeded")
                self.forecastTable.reloadData()
            }
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if let data = dailyData?.data {

            print("got number of rows!")
            return data.count
        } else {
            print("problem getting number of rows")
            return 0
        }
    }
    
//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        guard let data = dailyData?.data[row].summary else { return "error" }
//        print(data)
//        return data
//    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }

        if let summary = dailyData?.data[row].summary {
            print(summary)
            print("assigning summary success!")
            vw.textField?.stringValue = summary
        }
        return vw
    }

}
