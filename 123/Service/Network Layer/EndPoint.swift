//
//  EndPointType.swift
//  123
//
//  Created by Andrey on 18/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}



enum WeatherAPI {
    case getMainImage(id:Int, query: String)
    case getCityData(text: String)
    case getFiveDayWeather(city: String)
    case getCityByLocation(lat: Double, lon: Double)
}

extension WeatherAPI: EndPoint {
    
    var environmentBaseURL : String {
        switch self {
        case .getMainImage: return "https://api.unsplash.com/search"
        case .getFiveDayWeather: return "http://dataservice.accuweather.com"
        case .getCityData:
            return "http://dataservice.accuweather.com"
        case .getCityByLocation:
            return "http://dataservice.accuweather.com"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getMainImage:
            return "photos"
        case .getCityData:
            return "locations/v1/cities/search"
        case .getFiveDayWeather(let text):
            return "/forecasts/v1/daily/5day/\(text)"
        case .getCityByLocation:
            return "locations/v1/cities/geoposition/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getMainImage(let page, let query):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "query":query,
                                      "client_id":NetworkManager.correct])
        case .getFiveDayWeather:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["apikey":NetworkManager.MovieAPIKey,
                                                      "language":"ru",
                                                      "details":"true",
                                                      "metric":"true"])
        case .getCityByLocation(let lat, let lon):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["apikey":NetworkManager.MovieAPIKey,
                                                      "q":"\(lat),\(lon)"])
        case .getCityData(let text):
            return .requestParameters(bodyParameters: nil,
            bodyEncoding: .urlEncoding,
            urlParameters: ["apikey":NetworkManager.MovieAPIKey,
            "q":text])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}



