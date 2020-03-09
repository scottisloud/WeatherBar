//
//  SettingsViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2020/01/15.
//  Copyright © 2020 Scott Lougheed. All rights reserved.
//
import AppKit
import Foundation
import ServiceManagement

class SettingsViewController: NSViewController {
    
    @IBOutlet weak var unitsLabel: NSTextField!
    @IBOutlet weak var unitControl: NSSegmentedControl!
    @IBOutlet weak var quit: NSButton!
    @IBOutlet weak var darkSkyButton: NSButton!
    @IBOutlet weak var startAtLoginButton: NSButton!
    @IBOutlet weak var versionLabel: NSTextField!
    
    let launcherAppIdentifier = "com.scottlougheed.WeatherLauncher"
    let defaults = UserDefaults.standard
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setUpInterface()
        
        let units = defaults.integer(forKey: "units")
        unitControl.selectedSegment = units
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
    }
    
    override func viewWillDisappear() {
        
    }
    
    
    func setUpInterface() {
        
        if defaults.bool(forKey: "startAtLogin") {
            startAtLoginButton.state = .on
        } else {
            startAtLoginButton.state = .off
        }
        
        
        unitControl.setLabel("ºC/kph", forSegment: 0)
        unitControl.setLabel("ºF/mph", forSegment: 1)
        //        if UserDefaults.standard.bool(forKey: "startAtLogin") == true {
        //            startAtLoginButton.state = .on
        //        } else {
        //            startAtLoginButton.state = .off
        //        }
        darkSkyButton.title = "Powered by DarkSky"
        quit.title = "Quit"
        
        
        versionLabel.stringValue = "0.0.4-a01"
        
    }
    
    
    
    
    @IBAction func selectUnits(_ sender: NSSegmentedControl) {
        UserDefaults.standard.set(unitControl.selectedSegment, forKey: "units")
        
    }
    
    @IBAction func darkSkyButtonClicked(_ sender: NSButton) {
        NSWorkspace.shared.open(URL(string: "https://darksky.net/poweredby/")!)
    }
    
    @IBAction func startAtLoginChecked(_ sender: Any) {
        //TODO: Fill this in.
    }
    
    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
}
