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
    let mainVC = ViewController()

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create status/menu bar item called Weather. CLicking the menu bar item calls showWindow(_:) which displays the main view controller.
        if let button = statusItem.button {
                button.image = NSImage(named: "clear-day")
                button.image?.size = NSMakeSize(36.0, 36.0)
                button.action = #selector(showWindow)
        }
        
    }
    
    // Displays the main application window as a popup from the menu bar when clicked by the user
    @objc func showWindow(_ sender: NSStatusItem) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "MainViewController") as? ViewController else { return }
        let popoverView = NSPopover()
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

