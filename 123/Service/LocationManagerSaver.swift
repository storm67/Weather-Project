//
//  LocationManagerSaver.swift
//  123
//
//  Created by gdml on 01/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//


import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let locator = LocationManager()
    var access = false
    var data = false
    // MARK: - Properties
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0
        
        return locationManager
    }()

    weak var delegate: getLocation?
    
    
    func requestLocation() {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            }
        }
    
    
    fileprivate var locationHandler: (( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?)->())?
    
    public func getLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?)->()) {
        
        self.locationHandler = onCompletion
        
            // Request for Location Authorization
           requestLocation()
    }
   
}

extension LocationManager: CLLocationManagerDelegate {
    
    // MARK: - Location Change Authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.denied, CLAuthorizationStatus.notDetermined, CLAuthorizationStatus.restricted:
        break
        case .authorizedAlways, .authorizedWhenInUse:
        access = true
        delegate?.getLocation()
        manager.requestLocation()
        @unknown default:
        break
        }
    }
        
    
    
    // MARK: - Location Updates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let handler = self.locationHandler {
            if let location = locations.first {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                guard let placemarks = placemarks?[0], let town = placemarks.locality else { return }
                handler(location.coordinate,town, nil)
                }
            manager.delegate = nil
            manager.stopUpdatingHeading()
        } else { // Failed to get location
            }
        }
    }
    
    // MARK: - Location Did Fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}
