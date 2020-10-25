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
    case apiKeyWeather  = "W2HObTSzkC1Wwg3mfpFj5DaZhfqFu9Pq"
    }
    
    
}

enum Defaults {
    
    static let location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    static let dictionary: Dictionary <String, Int> = ["Санкт-петербург":295212,"Берлин":178087,"Ташкент":351199,"Будапешт": 187423,"Киев":324505,"Лос-анджелес":347625,"Омск":294463,"Воронеж":296543,"Ростов на дону":2951463,"Казань":295954,"Екатеринбург":295863,"Волгоград":29636,"Пермь":294922,"Москва":294021,"Новосибирск":294459,"Нижний новгород":294199,"Красноярск":293708,"Рига":225780,"Уфа":292177,"Самара":290396,"Каиро": 127164,"Баку":27103,"Венеция":2579882,"Челябинск":292332]
}
