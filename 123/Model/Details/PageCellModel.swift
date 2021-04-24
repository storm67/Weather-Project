//
//  PageCellModel.swift
//  123
//
//  Created by Storm67 on 13/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation

@objc class PageCellModel: NSObject, Codable {
    let name: String
    let date: Int
    var phrase: String?
    var temp: Int?
    init(name: String, date: Int, phrase: String?, temp: Int?) {
        self.name = name
        self.date = date
        self.phrase = phrase
        self.temp = temp
    }
}
