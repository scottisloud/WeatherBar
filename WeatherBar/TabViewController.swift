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
//    let forecastViewController = ForecastViewController()
    let settingsViewController = SettingsViewController()

    override func viewWillAppear() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedTabViewItemIndex = 0
        self.tabView.tabViewItems[0].label = "Current"
        self.tabView.tabViewItems[1].label = "Settings"
        

        
    }
    
}
