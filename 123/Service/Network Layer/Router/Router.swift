//
//  Router.swift
//  123
//
//  Created by Andrey on 18/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype P: EndPoint
    func request(_ route: P, completion: @escaping (Data) -> Void)
}


class Routing<P: EndPoint>: NetworkRouter {
    //private(set) var point: (P, @escaping (Data) -> Void) -> ()
    
//    init<E: NetworkRouter>(sourceObserver: E) where E.P == P {
//        self.point = sourceObserver.request
//    }
    
    func request(_ route: P, completion: @escaping (Data) -> Void) {
        do {
            let request = try self.buildRequest(from: route)
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                        switch result {
                        case .success:
                            guard let data = data else { return }
                            completion(data)
                        case .failure:
                            completion(Data())
                        }
                }
                }).resume()
        } catch {
            completion(Data())
            print(error)
        }
    }
    
    fileprivate func buildRequest(from route: P) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
            try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
            self.addAdditionalHeaders(additionalHeaders, request: &request)
            try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Swift.Result<String, Error> {
        switch response.statusCode {
        case 200...299: return .success("Excellent")
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}


 final class AnyLoaderBox<T: NetworkRouter>: Routing<T.P> {
    private let box: T

    init(_ box: T) {
    self.box = box
    }
    
    override func request(_ route: P, completion: @escaping (Data) -> Void) {
        box.request(route, completion: completion)
    }
}

final class AnyLoader<P: EndPoint>: NetworkRouter {
    private let box: Routing<P>

    init<C: NetworkRouter> (_ loader: C) where C.P == P {
        self.box = AnyLoaderBox(loader)
    }

    func request(_ route: P, completion: @escaping (Data) -> Void) {
        box.request(route, completion: completion)
    }

}

class cc: NSObject {
    let intLoder: Routing<WeatherAPI>
    let dataLoaderList: AnyLoader<WeatherAPI>
    init(re: Routing<WeatherAPI>) {
        self.intLoder = re
        self.dataLoaderList = AnyLoader(intLoder)
    }
    
    func ab() {
        dataLoaderList.request(.getCityData(text: "hello")) { (dd) in
            print(dd)
        }
    }
}
