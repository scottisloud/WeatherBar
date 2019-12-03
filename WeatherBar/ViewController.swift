//
//  ViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

// API Key: "960281f5a5cd1551f2f0446c79928e58"

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var icon: NSImageView!
    @IBOutlet weak var temperature: NSTextField!
    @IBOutlet weak var summary: NSTextField!
    @IBOutlet weak var precipValue: NSTextField!
    @IBOutlet weak var humidityValue: NSTextField!
    @IBOutlet weak var windSpeedValue: NSTextField!
    @IBOutlet weak var location: NSTextField!
    @IBOutlet weak var unitControl: NSSegmentedControl!
    @IBOutlet weak var refresh: NSButton!
    @IBOutlet weak var quit: NSButton!
    
    let bgColor = NSColor(srgbRed: 0.992, green: 0.632, blue: 0.0117, alpha: 1)
    
    override func viewDidLoad() {
		super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        location.stringValue = "West Lafayette, Indiana"
        
        icon.image = NSImage(named: "clear-day")
        
        
        // SET UP GENERAL APPEARANCE
        // Sets background of view to orange
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bgColor.cgColor
        
        // Set button titles
        refresh.image = NSImage(named: "NSRefreshTemplate")
        unitControl.setLabel("ºC", forSegment: 0)
        unitControl.setLabel("ºF", forSegment: 1)
        quit.title = "Quit"
         
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

    @IBAction func quitClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
    
}

