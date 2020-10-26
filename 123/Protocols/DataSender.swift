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

protocol NetworkingProtocol {
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

protocol ViewModelProtocol {
    typealias type = ([Convertible], Convertible) -> Void
    func newDebug(key: Int?, lat: Double?, lon: Double?, completion: @escaping (type))
    func returnit()
    func cellViewModel(index: Int) -> Convertible?
    func weatherFiveDayRequest(key: Int,completion: @escaping (type))
    var weather: [Convertible] { get set }
}

