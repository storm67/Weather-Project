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
    case apiKeyWeather  = "MrCfGUUEBSQg0Ii6XIFvpdjt8pNKTHC2"
    }
    
    
}

enum Defaults {
    
    static let location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    static let dictionary: Dictionary <String, Int> = ["Saint Petersburg":295212,"Los Angeles":347625,"Tashkent":351199,"Budapest": 187423,"Kiev":324505,"Berlin":178087,"Omsk":294463,"Voronezh":296543,"Rostov-on-Don":2951463,"Kazan":295954,"Ekaterinburg":295863,"Volgograd":29636,"Perm":294922,"Moscow":294021,"Novosibirsk":294459,"Nizhniy Novgorod":294199,"Krasnoyarsk":293708,"Riga":225780,"Ufa":292177,"Samara":290396,"Cairo": 127164,"Baku":27103,"Venezia":2579882,"Chelyabinsk":292332]
}
