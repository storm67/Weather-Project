//
//  SimpleModel.swift
//  123
//
//  Created by gdml on 12/06/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation

class SimpleModel {
    var name: String
    var key: Int?
    var lat: Double?
    var lon: Double?
    var position: Int
    var timeZone: Int
    init(name: String, key: Int?, lat: Double?, lon: Double?, position: Int, timeZone: Int) {
        self.name = name
        self.key = key
        self.lat = lat
        self.lon = lon
        self.position = position
        self.timeZone = timeZone
    }
}
