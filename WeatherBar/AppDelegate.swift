//
//  AppDelegate.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import AppKit
import ServiceManagement


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let mainVC = TabViewController()
    let currentViewController = CurrentViewController()
    let locationClient = Location()
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // MARK: - LAUNCH AT LOGIN-RELATED
        var startedAtLogin = false
        let launcherAppIdentifier = "com.scottlougheed.WeatherLauncher"
        
        for app in NSWorkspace.shared.runningApplications {
            if app.bundleIdentifier == launcherAppIdentifier {
                startedAtLogin = true
            }
            
            if startedAtLogin {
                DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier)
            }
        }
    
        // MARK: - INTERFACE
		//Create menu bar item called Weather. CLicking the menu bar item calls showWindow(_:) which displays the main view controller.
        if let button = statusItem.button {
            button.image = NSImage(named: "menuBarIconFilled")
            button.action = #selector(showWindow)
        }

        
        currentViewController.userLocation = locationClient.getLocation()
    }
    
    
    // Displays the main application window as a popup from the menu bar when clicked by the user
    @objc func showWindow(_ sender: NSStatusItem) {
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "MainViewController") as? TabViewController else { return }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
		popoverView.animates = false
        popoverView.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}


// MARK: - Launcher

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}
