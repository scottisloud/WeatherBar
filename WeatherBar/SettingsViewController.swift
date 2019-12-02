//
//  SettingsViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/2.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {

    @IBOutlet weak var settingsTitle: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTitle.stringValue = "Settings"
    }
    
    @IBAction func backButton(_ sender: NSButton) {
        // Returns user to main view

        print("Back Button Pressed")
    }
}
