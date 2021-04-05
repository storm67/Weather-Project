//
//  12HoursForecast.swift
//  123
//
//  Created by Storm67 on 05/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

class HoursForecast: Decodable {
    var humidity: Int
    init(dict: JSON) {
        humidity = dict["RelativeHumidity"].intValue
    }
}
