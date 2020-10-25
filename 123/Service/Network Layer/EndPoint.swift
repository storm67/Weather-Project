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
    case getCityByLocation(lat: Int, lon: Int)
}

extension WeatherAPI: EndPoint {
    
    var environmentBaseURL : String {
        switch self {
        case .getMainImage: return "https://api.unsplash.com/search"
        case .getFiveDayWeather: return "http://dataservice.accuweather.com/forecasts"
        case .getCityData:
            return ""
        case .getCityByLocation:
            return ""
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
        case .getCityData(let text):
        return text
        case .getFiveDayWeather(let text):
        return "v1/daily/5day/\(text)"
        case .getCityByLocation(let geo):
        return "\(geo.lat)"
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
                                      "client_id":NetworkManager.MovieAPIKey])
        case .getFiveDayWeather:
        return .requestParameters(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
        urlParameters: ["apikey":NetworkManager.MovieAPIKey,
        "language":"en"])
//        case .getCityByLocation(let text):
//        return .requestParameters(bodyParameters: nil,
//        bodyEncoding: .urlEncoding,
//        urlParameters: ["page":page,
//        "query":query,
//        "client_id":NetworkManager.MovieAPIKey])
//        case .getCityData(let text):
//            return .requestParameters(bodyParameters: nil,
//            bodyEncoding: .urlEncoding,
//            urlParameters: ["page":page,
//            "query":query,
//            "client_id":NetworkManager.MovieAPIKey])
        default:
        return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}



