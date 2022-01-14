//
//  DataSender.swift
//  PizdecProject
//
//  Created by gdml on 04/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol getLocation: AnyObject {
    func getLocation()
}

protocol OpenSelectorManager: AnyObject {
    func open()
}

protocol NavigationBackDetector: AnyObject {
    var isMoveToParent: Bool { get set }
}

protocol TransitionCurrentSizeManager: AnyObject {
    var height: CGFloat { get set }
}

protocol ViewModelProtocol {
    typealias Completion = ([Convertible], Convertible, [AirQuality]) -> Void
    func newDebug(key: Int?, lat: Double?, lon: Double?, completion: @escaping (Completion))
    func returnit()
    func cellViewModel(index: Int) -> Convertible?
    func weatherFiveDayRequest(key: Int,completion: @escaping (Completion))
    var weather: [Convertible] { get set }
    var pageViewModel: PageManagerProtocol! { get set }
    func extractor() -> Bool
}

protocol Reciever: class {
    func getTrigger()
}
