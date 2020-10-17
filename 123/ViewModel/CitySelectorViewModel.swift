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
    private(set) var weatherManager: NetworkingProtocol
    static let cellID = "cell"
    
    func checkCity(by searchText: String, completion: @escaping () -> Void) {
        
        let initIt = Test(str: searchText, key: nil, lat: nil, lon: nil)
        let Operator = Init(test: initIt)
        
        weatherManager.request(router: Operator.getCities()) { [weak self] data in
            let converted = JSON(data).arrayValue
            let cvm = converted.map { CityModel(mod: $0) }
            let vvm = cvm.map { CellViewModel(reg: $0) }
            self?.searchElements = vvm
            completion()
        }
    }
    func createData(name: String) -> Bool {
        return coreDataManager.createData(name: name, key: nil, lat: nil, lon: nil)
    }
    
    func createDataFromTag(name: String, key: Int) -> Bool {
        return coreDataManager.createData(name: name, key: Double(key), lat: nil, lon: nil)
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
        
        func setLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?)->()) {
            locationManager.getLocation { (coord, name, err) in
                onCompletion(coord,name,err)
            }
        }
    
    
        func createFromLocation(name: String, lat: Double?, lon: Double?) {
        coreDataManager.createData(name: name, key: nil, lat: lat, lon: lon)
        }
        
        init(manager: NetworkingProtocol,
             location: LocationManagerProtocol,
             coreData: CoreDataProtocol) {
            self.weatherManager = manager
            self.coreDataManager = coreData
            self.locationManager = location
        }
    }
    protocol CitySelectorProtocol {
        func checkCity(by searchText: String, completion: @escaping () -> Void)
        func cellViewModel(index: Int) -> CellViewModel?
        func createData(name: String) -> Bool
        func getLocation()
        func createDataFromTag(name: String, key: Int) -> Bool
        func setLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?)->())
        func createFromLocation(name: String, lat: Double?, lon: Double?)
        func checkAccess(access: Bool) -> Bool
        init(manager: NetworkingProtocol,location: LocationManagerProtocol,coreData: CoreDataProtocol)
        var searchElements: [CellViewModel] { get }
}
