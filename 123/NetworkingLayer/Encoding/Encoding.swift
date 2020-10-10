//
//  Encoding.swift
//  123
//
//  Created by gdml on 12/06/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
public protocol ParameterEncoder {
     func encode<T>(by request: Resource<T>) throws
}
public enum ParameterEncoding {

case urlEncoding
case jsonEncoding
case urlAndJsonEncoding
}
public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
