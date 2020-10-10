//
//  CellViewModel.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation

final class CellViewModel {
let name: String
let key: Int
let country: String
    
    init(reg: CityModel) {
        self.name = reg.cityName
        self.country = reg.country
        self.key = reg.key
    }
}

