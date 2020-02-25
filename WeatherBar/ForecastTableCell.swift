//
//  ForecastTableCell.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2020/2/24.
//  Copyright © 2020 Scott Lougheed. All rights reserved.
//

import Cocoa

class ForecastTableCell: NSTableCellView {

	@IBOutlet weak var forecastCellIcon: NSImageView!
	@IBOutlet weak var forecastCellSummaryLabel: NSTextField!
	@IBOutlet weak var weekdayLabel: NSTextField!
	@IBOutlet weak var precipValue: NSTextField!
	@IBOutlet weak var windSpeedValue: NSTextField!
	@IBOutlet weak var highTempValue: NSTextField!
	@IBOutlet weak var lowTempVlue: NSTextField!
	
	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
