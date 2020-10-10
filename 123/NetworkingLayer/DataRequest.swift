//
//  DataRequest.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import RxSwift

public struct Resource<T> {
    let url: URL
    var parameter: [String: String]?
}

protocol NetworkingManager {
    func load<T: Decodable>(resource: Resource<T>) -> Observable<T>
}

final class NetworkManager: NetworkingManager {
    func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        if resource.parameter != nil {
            return URLRequest.loadWithPayLoad(resource: resource)
        } else {
            return URLRequest.load(resource: resource)
        }
    }
}
