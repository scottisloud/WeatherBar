//
//  SettingsViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2020/01/15.
//  Copyright © 2020 Scott Lougheed. All rights reserved.
//
import AppKit
import Foundation

class SettingsViewController: NSViewController {
    
    @IBOutlet weak var unitsLabel: NSTextField!
    @IBOutlet weak var unitControl: NSSegmentedControl!
    @IBOutlet weak var quit: NSButton!
    @IBOutlet weak var darkSkyButton: NSButton!
    @IBOutlet weak var startAtLoginButton: NSButton!
    
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setUpInterface()
        let defaults = UserDefaults.standard
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
        unitControl.setLabel("ºC", forSegment: 0)
        unitControl.setLabel("ºF", forSegment: 1)
        if UserDefaults.standard.bool(forKey: "startAtLogin") == true {
            startAtLoginButton.state = .on
        } else {
            startAtLoginButton.state = .off
        }
        darkSkyButton.title = "Powered by DarkSky"
        quit.title = "Quit"
    }
    
    
    
    
    @IBAction func selectUnits(_ sender: NSSegmentedControl) {
        UserDefaults.standard.set(unitControl.selectedSegment, forKey: "units")
        
        print("Selected Units Pressed")
    }
    
    @IBAction func darkSkyButtonClicked(_ sender: NSButton) {
        NSWorkspace.shared.open(URL(string: "https://darksky.net/poweredby/")!)
    }
    
    @IBAction func startAtLoginChecked(_ sender: Any) {
        if startAtLoginButton.state == .on {
            UserDefaults.standard.set(true, forKey: "startAtLogin")
        } else {
            UserDefaults.standard.set(false, forKey: "startAtLogin")
        }
        
        
    }
    
    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
}
