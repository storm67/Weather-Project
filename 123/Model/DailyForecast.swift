//
//  OneDayWeatherModel.swift
//  123
//
//  Created by gdml on 13/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

class DailyForecast {
    var date: String
    var temperature: Int
    var dayIcon: Int
    var nightIcon: Int
    var dayIconPhrase: String
    var nightIconPhrase: String
    var realFeel: Int
    var wind: Int
    init(dictionary: JSON) {
        date = dictionary["Date"].stringValue
        temperature = dictionary["Temperature"]["Minimum"]["Value"].intValue
        dayIcon = dictionary["Day"]["Icon"].intValue
        nightIcon = dictionary["Night"]["Icon"].intValue
        dayIconPhrase = dictionary["Day"]["IconPhrase"].stringValue
        nightIconPhrase = dictionary["Night"]["IconPhrase"].stringValue
        realFeel = dictionary["RealFeelTemperature"]["Minimum"]["Value"].intValue
        wind = dictionary["Wind"]["Speed"]["Value"].intValue
    }
}
