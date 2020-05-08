//
//  FiveDayWeather.swift
//  123
//
//  Created by gdml on 23/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation

class Convertible {
    var date: String
    var temperature: Int
    var dayIcon: Int
    var dayIconPhrase: String
    var nightIconPhrase: String
    var realFeel: Int
    var wind: Int
    var standardDate: String
    init(date: String, temperature: Int, dayIcon: Int, dayIconPhrase: String, nightIconPhrase: String, realFeel: Int, wind: Int, standardDate: String) {
        self.standardDate = standardDate
        self.realFeel = realFeel
        self.wind = wind
        self.date = date
        self.temperature = temperature
        self.dayIcon = dayIcon
        self.dayIconPhrase = dayIconPhrase
        self.nightIconPhrase = nightIconPhrase
    }
}


