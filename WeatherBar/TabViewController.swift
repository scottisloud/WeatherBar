//
//  TabViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2020/01/15.
//  Copyright © 2020 Scott Lougheed. All rights reserved.
//
import AppKit
import Cocoa
import CoreLocation
import Foundation


class TabViewController: NSTabViewController {
    
    let currentViewController = CurrentViewController()
    let forecastViewController = ForecastViewController()
    let settingsViewController = SettingsViewController()
    
//    let client = DarkSkyClient()
//    let locationClient = Location()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabView.tabViewItems[0].label = "Current"
        self.tabView.tabViewItems[1].label = "Forecast"
        self.tabView.tabViewItems[2].label = "Settings"
        view.translatesAutoresizingMaskIntoConstraints = false
        
    
    }
    

}
