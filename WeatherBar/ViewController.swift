//
//  ViewController.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2019/12/1.
//  Copyright © 2019 Scott Lougheed. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let bgColor = NSColor(srgbRed: 0.992, green: 0.632, blue: 0.0117, alpha: 1)
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


}

