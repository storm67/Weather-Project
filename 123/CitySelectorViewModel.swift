//
//  ViewModel.swift
//  PizdecProject
//
//  Created by gdml on 04/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON
import CoreLocation

final class CitySelectorViewModel: CitySelectorProtocol {
    
    private(set) var coreDataManager: CoreDataProtocol
    private(set) var locationManager: LocationManagerProtocol
    private(set) var searchElements = [CellViewModel]()
    private(set) var networkManager: Routing<WeatherAPI>
    static let cellID = "cell"

    func checkCity(by searchText: String, completion: @escaping () -> Void) {
        networkManager.request(.getCityData(text: searchText)) { [weak self] data in
            let converted = JSON(data).arrayValue
            let cvm = converted.map { CityModel(mod: $0) }
            let vvm = cvm.map { CellViewModel(reg: $0) }
            self?.searchElements = vvm
            completion()
        }
    }
    func createData(name: String, timeZone: String) -> Bool {
        return coreDataManager.createData(name: name, key: nil, lat: nil, lon: nil, timeZone: timeZone)
    }

    func createDataFromTag(name: String, key: Int, timeZone: String) -> Bool {
        return coreDataManager.createData(name: name, key: Double(key), lat: nil, lon: nil, timeZone: timeZone)
    }

    func checkAccess(access: Bool) -> Bool {
        if access {
            self.locationManager.data = true
            guard self.locationManager.access else { return false }
            guard self.locationManager.data else { return false }
            return true
        }
        return false
    }

        func cellViewModel(index: Int) -> CellViewModel? {
            guard index < searchElements.count else { return nil }
            return searchElements[index]
        }

        func getLocation() {
            locationManager.requestLocation()
        }

    func setLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?, _ timeZone: TimeZone)->()) {
            locationManager.getLocation { (coord, name, err, timeZone) in
                onCompletion(coord,name,err, timeZone)
            }
        }


    func createFromLocation(name: String, lat: Double?, lon: Double?, timeZone: String) {
        coreDataManager.createData(name: name, key: nil, lat: lat, lon: lon, timeZone: timeZone)
        }
    
    func getTimeZone(_ title: String) -> String {
        var timeZone = ""
        networkManager.request(.getCityData(text: title)) { (data) in
        let converted = JSON(data).arrayValue
        let model = converted.map { CityModel(mod: $0) }
        model.forEach { data in
        timeZone = data.timeZone
        }
    }
        return timeZone
}

    init(manager: Routing<WeatherAPI>,
             location: LocationManagerProtocol,
             coreData: CoreDataProtocol) {
            self.networkManager = manager
            self.coreDataManager = coreData
            self.locationManager = location
        }
    }

    protocol CitySelectorProtocol {
        func checkCity(by searchText: String, completion: @escaping () -> Void)
        func cellViewModel(index: Int) -> CellViewModel?
        func createData(name: String, timeZone: String) -> Bool
        func getLocation()
        func createDataFromTag(name: String, key: Int, timeZone: String) -> Bool
        func setLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?, _ timeZone: TimeZone)->())
        func createFromLocation(name: String, lat: Double?, lon: Double?, timeZone: String)
        func checkAccess(access: Bool) -> Bool
        init(manager: Routing<WeatherAPI>,
        location: LocationManagerProtocol,
        coreData: CoreDataProtocol)
        var searchElements: [CellViewModel] { get }
        func getTimeZone(_ title: String) -> String
}