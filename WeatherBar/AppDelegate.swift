//
//  AppDelegate.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create status/menu bar item called Weather. CLicking the menu bar item calls showWindow(_:) which displays the main view controller.
        if let button = statusItem.button {
            button.image = NSImage(named: "clear-day")
            button.image?.size = NSMakeSize(36.0, 36.0)
            button.action = #selector(showWindow)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
        
    //Displays the main application window as a popup from the menu bar when clicked by the user
    @objc func showWindow(_ sender: NSStatusItem) {
                
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "MainViewController") as? ViewController else { return }
        NSApplication.shared.activate(ignoringOtherApps: true)
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
    }
        
    //	func addConfigurationMenuItem() {
    //		let separator = NSMenuItem(title: "Settings", action: #selector(showSettings), keyEquivalent: "")
    //
    //		statusItem.menu?.addItem(separator)
    //	}
    //
    //	@objc func showSettings(_ sender: NSMenuItem) {
    //		//PLACEHOLDER
    //	}
    
    
}

