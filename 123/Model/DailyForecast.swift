//
//  OneDayWeatherModel.swift
//  123
//
//  Created by gdml on 13/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

final class DailyForecast: Codable {
    var date: String
    var temperature: Int
    var temperatureMax: Int
    var dayIcon: Int
    var nightIcon: Int
    var dayIconPhrase: String
    var nightIconPhrase: String
    var realFeel: Int
    var wind: Int
    var airQuality: Int
    var sunRise: Int
    var sunset: Int
    var humidity: Int
    var direction: String
    
    init(dictionary: JSON) {
        date = dictionary["Date"].stringValue
        temperature = dictionary["Temperature"]["Minimum"]["Value"].intValue
        temperatureMax = dictionary["Temperature"]["Maximum"]["Value"].intValue
        dayIcon = dictionary["Day"]["Icon"].intValue
        nightIcon = dictionary["Night"]["Icon"].intValue
        dayIconPhrase = dictionary["Day"]["IconPhrase"].stringValue
        nightIconPhrase = dictionary["Night"]["IconPhrase"].stringValue
        realFeel = dictionary["RealFeelTemperature"]["Minimum"]["Value"].intValue
        wind = dictionary["Day"]["Wind"]["Speed"]["Value"].intValue
        airQuality = 3
        sunRise = dictionary["Sun"]["EpochRise"].intValue
        sunset = dictionary["Sun"]["EpochSet"].intValue
        humidity = dictionary["RelativeHumidity"].intValue
        direction = dictionary["Day"]["Wind"]["Direction"]["Localized"].stringValue
    }
    
    init(alternativeDictionary: JSON) {
        date = alternativeDictionary["DateTime"].stringValue
        temperature = alternativeDictionary["RealFeelTemperature"]["Value"].intValue
        temperatureMax = alternativeDictionary["Temperature"]["Maximum"]["Value"].intValue
        dayIcon = alternativeDictionary["Day"]["Icon"].intValue
        nightIcon = alternativeDictionary["Night"]["Icon"].intValue
        dayIconPhrase = alternativeDictionary["Day"]["IconPhrase"].stringValue
        nightIconPhrase = alternativeDictionary["Night"]["IconPhrase"].stringValue
        realFeel = alternativeDictionary["RealFeelTemperature"]["Minimum"]["Value"].intValue
        wind = alternativeDictionary["Day"]["Wind"]["Speed"]["Value"].intValue
        airQuality = 3
        sunRise = alternativeDictionary["Sun"]["EpochRise"].intValue
        sunset = alternativeDictionary["Sun"]["EpochSet"].intValue
        humidity = alternativeDictionary["RelativeHumidity"].intValue
        direction = alternativeDictionary["Day"]["Wind"]["Direction"]["Localized"].stringValue
    }
}
