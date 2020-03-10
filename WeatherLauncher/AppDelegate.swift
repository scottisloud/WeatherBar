//
//  AppDelegate.swift
//  WeatherLauncher
//
//  Created by Scott Lougheed on 2020/03/6.
//  Copyright © 2020 Scott Lougheed. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		let mainAppIdentifier = "com.scottlougheed.WeatherBar"
		
		  let path = NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: mainAppIdentifier)
		  
		  if let path = path
			{
			NSLog("opening main app at \(path)")
			NSWorkspace.shared.openFile(path)
			}
		  
		  NSApp.terminate(nil)
	}
	
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	@objc func terminate() {
		NSApp.terminate(nil)
	}
	
	
}

extension Notification.Name {
	static let killLauncher = Notification.Name("killLauncher")
}

