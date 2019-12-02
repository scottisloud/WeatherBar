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
    
    let bgColor = NSColor(srgbRed: 0.992, green: 0.632, blue: 0.0117, alpha: 1)
	
    let appDelegate = AppDelegate()
    
    override func viewDidLoad() {
		super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bgColor.cgColor
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
    
    
    //Displays the main application window as a popup from the menu bar when clicked by the user
    @objc func showWindow() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "MainViewController") as? ViewController else { return }
        
        let popoverView = NSPopover()
        
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: appDelegate.statusItem.button!.bounds , of: appDelegate.statusItem.button!, preferredEdge: .maxY)
    }


}

