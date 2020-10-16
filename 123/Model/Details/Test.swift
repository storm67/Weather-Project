//
//  Test.swift
//  123
//
//  Created by gdml on 11/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
final class Test {
    let str: String
    let key: Int
    let lat: Double
    let lon: Double
    init(str: String?, key: Int?, lat: Double?, lon: Double?) {
        self.str = str ?? ""
        self.key = key ?? 0
        self.lat = lat ?? 0
        self.lon = lon ?? 0
    }
}
class Init: Operator {
    
    var test: Test
    init(test: Test) {
        self.test = test
    }
    
    public func getCities() -> Router {
    return Router.getCityData(info:self.test)
    }
    
    public func getWeather() -> Router {
    return Router.getFiveDayWeather(city: self.test)
    }
    
    public func geoLocate() -> Router {
    return Router.getCityByLocation(geo: self.test)
    }
}


