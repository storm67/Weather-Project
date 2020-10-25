//
//  NetworkManager.swift
//  123
//
//  Created by Andrey on 18/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
struct array:Decodable {
    let results: [slava]
}
struct slava:Decodable {
    let urls: ukraina
}
struct ukraina: Decodable {
    let full: String
}
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
    static let MovieAPIKey = "W2HObTSzkC1Wwg3mfpFj5DaZhfqFu9Pq"
    
//    func getMainImage<T: Decodable>(_ int: Int,_ query: String, completion: @escaping ((Swift.Result<slava, Error>) -> Void)) {
//        router.request(.getMainImage(id: page, query: query)) { data, response, error in
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let data = data else { return }
//                    do {
//                        let apiResponse = try JSONDecoder().decode([T].self, from: data)
//                        completion(apiResponse)
//                    } catch {
//                        completion(nil)
//                    }
//                case .failure:
//                    completion(nil)
//                }
//            }
//        }
//    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) throws -> Swift.Result<String, Error> {
        switch response.statusCode {
        case 200...299: return .success("Excellent")
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}

