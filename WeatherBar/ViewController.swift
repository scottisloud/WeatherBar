//
//  ViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var icon: NSImageView!
    @IBOutlet weak var temperature: NSTextField!
    @IBOutlet weak var summary: NSTextField!
    @IBOutlet weak var precipValue: NSTextField!
    @IBOutlet weak var humidityValue: NSTextField!
    @IBOutlet weak var location: NSTextField!
    @IBOutlet weak var settings: NSButton!
    @IBOutlet weak var quit: NSButton!
    
    let bgColor = NSColor(srgbRed: 0.992, green: 0.632, blue: 0.0117, alpha: 1)
	
    
    
    override func viewDidLoad() {
		super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        location.stringValue = "West Lafayette, Indiana"

        // SET UP GENERAL APPEARANCE
        // Sets background of view to orange
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bgColor.cgColor
        
        // Set button titles
        settings.title = "Settings"
        quit.title = "Quit"
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

    
    // SETTINGS BUTTON ACTION
    @IBAction func settingsClicked(_ sender: NSButton) {
        print("Settings Clicked")
        
        
//        let storyboard: NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
//        guard let settingsViewController = storyboard.instantiateController(withIdentifier: "SettingsViewController") as? ViewController else { return }
//

    }

    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
    
}

