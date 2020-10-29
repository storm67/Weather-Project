//
//  NetworkManager.swift
//  123
//
//  Created by Andrey on 18/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}


struct NetworkManager {
    static let MovieAPIKey = "oDxNrlh4n0HPGUVfeGr2UM6TupGCeNKF"
    static let correct = "kR4oPovT6RYCVnia0W8mJOiraFGmrvNZMNi3BBGBhdA"
}

