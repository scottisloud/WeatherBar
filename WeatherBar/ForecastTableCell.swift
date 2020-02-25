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
	
	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
