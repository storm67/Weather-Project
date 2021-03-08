//
//  WeatherModel.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CityModel: Decodable {
    let cityName: String
    let region: String
    let country: String
    let republic: String
    let key: Int
    let timeZone: Int
    init(mod: JSON) {
        cityName = mod["LocalizedName"].stringValue
        region = mod["Region"]["LocalizedName"].stringValue
        country = mod["Country"]["LocalizedName"].stringValue
        republic = mod["LocalizedName"]["LocalizedType"].stringValue
        key = mod["Key"].intValue
        timeZone = mod["TimeZone"]["GmtOffset"].intValue
    }
}
