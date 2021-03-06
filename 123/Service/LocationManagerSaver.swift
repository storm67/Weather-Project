//
//  LocationManagerSaver.swift
//  123
//
//  Created by gdml on 01/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//


import Foundation
import CoreLocation

final class LocationManager: NSObject, LocationManagerProtocol {
    
    public var access: Bool = false
    public var data: Bool = false
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
    
    
    fileprivate var locationHandler: (( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?, _ timeZone: TimeZone)->())?
    
    public func getLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?, _ timeZone: TimeZone)->()) {
        
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
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    
    // MARK: - Location Updates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let handler = self.locationHandler {
            if let location = locations.first {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                guard let placemarks = placemarks?[0], let town = placemarks.locality, let timeZone = placemarks.timeZone else { return }
                handler(location.coordinate,town, nil, timeZone)
                }
            manager.delegate = nil
            manager.stopUpdatingHeading()
        } else { // Failed to get location
            }
        }
    }
}

protocol LocationManagerProtocol: class {
    func requestLocation()
    func getLocation(onCompletion:@escaping ( _ locations: CLLocationCoordinate2D?,_ name: String, _ error: Error?, _ timeZone: TimeZone)->())
    var data: Bool { get set }
    var access: Bool { get }
}

