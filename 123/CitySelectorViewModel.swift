//
//  ViewModel.swift
//  PizdecProject
//
//  Created by gdml on 04/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//
import Foundation
import SwiftyJSON
import CoreLocation
import Swinject

final class CitySelectorViewModel: LocationInterface, CitySelectorProtocol {
    
    private(set) var searchElements = [CellViewModel]()
    private(set) var networkManager: Routing<WeatherAPI>    
    
    func checkCity(by searchText: String, completion: @escaping () -> Void) {
        networkManager.request(.getCityData(text: searchText)) { [weak self] data in
            let converted = JSON(data).arrayValue
            let cvm = converted.map { CityModel(mod: $0) }
            let vvm = cvm.map { CellViewModel(reg: $0) }
            self?.searchElements = vvm
            completion()
        }
    }
    
    func createData(name: String, key: Int, timeZone: Int) -> Bool {
        return coreDataManager.createData(name: name, key: Double(key), lat: nil, lon: nil, timeZoneOffset: timeZone)
    }
    
    func createDataFromTag(name: String, key: Int, timeZone: Int) -> Bool {
        return coreDataManager.createData(name: name, key: Double(key), lat: nil, lon: nil, timeZoneOffset: timeZone)
    }
    
    func cellViewModel(index: Int) -> CellViewModel? {
        guard index < searchElements.count else { return nil }
        return searchElements[index]
    }
    
    func getTimeZone(_ title: String, completion: @escaping (Int) -> (Void)) {
        networkManager.request(.getCityData(text: title)) { (data) in
            let converted = JSON(data).arrayValue
            let model = converted.map { CityModel(mod: $0) }
            completion(model[0].timeZone)
        }
    }
    
    init(manager: Routing<WeatherAPI>) {
        self.networkManager = manager
        let location = Assembler.sharedAssembler.resolver.resolve(LocationManagerProtocol.self)!
        let coreDataManager = Assembler.sharedAssembler.resolver.resolve(CoreDataProtocol.self)!
        super.init(locationManager: location, coreDataManager: coreDataManager)
    }
}

protocol CitySelectorProtocol: LocationInterfaceProtocol {
    func checkCity(by searchText: String, completion: @escaping () -> Void)
    func cellViewModel(index: Int) -> CellViewModel?
    func createData(name: String, key: Int, timeZone: Int) -> Bool
    func createDataFromTag(name: String, key: Int, timeZone: Int) -> Bool
    init(manager: Routing<WeatherAPI>)
    var searchElements: [CellViewModel] { get }
    func getTimeZone(_ title: String, completion: @escaping (Int) -> (Void))
}

protocol LocationInterfaceProtocol {
    func getLocation()
    func checkAccess(access: Bool) -> Bool
    func setLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?, _ timeZone: TimeZone) -> ())
    func createFromLocation(name: String, lat: Double?, lon: Double?, timeZone: Int)
}


