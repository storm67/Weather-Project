//
//  ImageModel.swift
//  123
//
//  Created by Andrey on 27/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageModel {
    let link: String
    init(js: JSON) {
        link = js["urls"]["full"].stringValue
    }
}
