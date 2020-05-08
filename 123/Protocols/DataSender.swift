//
//  DataSender.swift
//  PizdecProject
//
//  Created by gdml on 04/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DataSender {
    func set(completion: @escaping ([CellViewModel]) -> Void)
}
protocol DataSend {
    func request(router: Router, data: @escaping (JSON) -> Void)
}
protocol Operator {
    func getCities() -> Router
    func getWeather() -> Router
    func geoLocate() -> Router
}
protocol MyViewDelegate: class {
    func didTapButton()
}
protocol getLocation: class {
    func getLocation()
}
protocol SelectRow: class {
    func sendModel(_ model: CellViewModel)
}
protocol Alias {
    typealias type = ([Convertible], Convertible) -> Void
}

