//
//  HTTPMethod.swift
//  123
//
//  Created by gdml on 12/06/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation


public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum HTTPTask<T> {
    case request
    case requestParameters(bodyParameters: Resource<T>)
}
