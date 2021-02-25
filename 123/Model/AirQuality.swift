//
//  AirQuality.swift
//  123
//
//  Created by Storm67 on 10/01/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

final class AirQuality: Decodable {
    var value: Int
    init(decoder: JSON) {
        value = decoder["Value"].intValue
    }
}
