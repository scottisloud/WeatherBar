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
		let runningApps = NSWorkspace.shared.runningApplications
		var isRunning = false
		
        for app in runningApps {
            if app.bundleIdentifier == mainAppIdentifier {
                isRunning = true
                break
            }
        }
        
        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killLauncher, object: mainAppIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast(3)
            components.append("MacOS")
            components.append("WeatherBar")
            
            let newPath = NSString.path(withComponents: components)
            
            NSWorkspace.shared.launchApplication(newPath)
        }
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

