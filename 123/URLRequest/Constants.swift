//
//  Constants.swift
//  123
//
//  Created by gdml on 11/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import CoreLocation

public struct Constants {
    //"http://dataservice.accuweather.com/forecasts/v1/daily/1day/294021?apikey=R3TQhFT5Q4J24ShJvdyfpQdk9sQsSTdI"
    
    //"http://dataservice.accuweather.com/locations/v1/cities/search?apikey=R3TQhFT5Q4J24ShJvdyfpQdk9sQsSTdI&q=
        
    
    enum AppKeyAndUrls : String {
    case baseURL        = "http://dataservice.accuweather.com/"
    case requestCity    = "locations/v1/cities/search?"
    case requestWeather = "forecasts/v1/daily/1day/"
    case fiveDayRequest = "forecasts/v1/daily/5day/"
    case geoSearch      = "locations/v1/cities/geoposition/search"
    case apiKeyWeather  = "YGHBznxuicIjPCDgXFp3E5jL3WVEJUWE"
    }
    
    
}

enum Defaults {
    
    static let location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
}
