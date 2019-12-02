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

	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		statusItem.button?.title = "Weather"
		
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	func addConfigurationMenuItem() {
		let separator = NSMenuItem(title: "Settings", action: #selector(showSettings), keyEquivalent: "")
		
		statusItem.menu?.addItem(separator)
	}
	
	@objc func showSettings(_ sender: NSMenuItem) {
		//PLACEHOLDER
	}

}

