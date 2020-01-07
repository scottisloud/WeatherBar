//
//  DarkSkyError.swift
//  WeatherBar
//
//  Created by Scott Lougheed on 2020/1/3.
//  Copyright © 2020 Scott Lougheed. All rights reserved.
//

import Foundation

enum DarkSkyError: Error {
	case RequestFailed
	case ResponseUnsuccessful(statusCode: Int)
    case BadAPICall
}

