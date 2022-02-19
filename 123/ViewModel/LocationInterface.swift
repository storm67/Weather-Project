//
//  LocationInterface.swift
//  123
//
//  Created by Storm67 on 08/05/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import CoreLocation

class LocationInterface: LocationInterfaceProtocol {
    
    var locationManager: LocationManagerProtocol
    var coreDataManager: CoreDataProtocol 
    init(locationManager: LocationManagerProtocol, coreDataManager: CoreDataProtocol) {
        self.locationManager = locationManager
        self.coreDataManager = coreDataManager
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
    
    func getLocation() {
        locationManager.requestLocation()
    }
    
    func setLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?, _ timeZone: TimeZone)->()) {
        locationManager.getLocation { (coord, name, err, timeZone) in
            onCompletion(coord,name,err, timeZone)
        }
    }
    
    func createFromLocation(name: String, lat: Double?, lon: Double?, timeZone: Int) {
        Defaults.locationTag = true
        coreDataManager.createData(name: name, key: nil, lat: lat, lon: lon, timeZoneOffset: timeZone)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            Defaults.locationTag = false
        }
    }
}
