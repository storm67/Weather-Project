//
//  URLRequest.swift
//  123
//
//  Created by gdml on 11/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import Alamofire

public protocol URLRequestConvertible {
    /// The URL request.
    var urlRequest: URLRequest { get }
}

enum Router: URLRequestConvertible {
    
    static let baseUrl = Constants.AppKeyAndUrls.baseURL
        
    case getCityData(info: Test)
   
    case getFiveDayWeather(city: Test)

    case getCityByLocation(geo: Test)
    

    //Request Type
    var method: String {
        switch self {

        case .getCityData:
            return Alamofire.HTTPMethod.get.rawValue
    
        case .getFiveDayWeather:
            return Alamofire.HTTPMethod.get.rawValue
        
        case .getCityByLocation:
            return Alamofire.HTTPMethod.get.rawValue
            
        }
    }
    var path: String {
        switch self {
        case .getCityData(let test):
            return "\(Router.baseUrl.rawValue)\(Constants.AppKeyAndUrls.requestCity.rawValue)apikey=\(Constants.AppKeyAndUrls.apiKeyWeather.rawValue)&q=\(test.str)"
            
        case .getFiveDayWeather(let cityKey):
            return "\(Router.baseUrl.rawValue)\(Constants.AppKeyAndUrls.fiveDayRequest.rawValue)\(cityKey.key)?apikey=\(Constants.AppKeyAndUrls.apiKeyWeather.rawValue)&language=ru"
            
        case .getCityByLocation(let geo):
            return "\(Router.baseUrl.rawValue)\(Constants.AppKeyAndUrls.geoSearch.rawValue)?apikey=\(Constants.AppKeyAndUrls.apiKeyWeather.rawValue)&q=\(String(describing: geo.lat)),\(String(describing: geo.lon))"

        }
    }
    
    //Generate request
    public var urlRequest: URLRequest {
        
        let completeURLString = path
        let urlString = completeURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: urlString)
        print(url)
        var request = URLRequest(url: url!)
        request.httpMethod = method
        do{
            return try Alamofire.JSONEncoding.default.encode(request)
        }
        catch
        {
            print(error.localizedDescription)
        }
        return request
        }
    }
