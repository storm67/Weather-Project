//
//  DataRequest.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NetworkService: NetworkingProtocol {
    func request(router: Router, data: @escaping (JSON) -> Void) {
        Alamofire.AF.request(router.urlRequest).validate().responseJSON { (response) in switch response.result {
        case .success:
            print(router.urlRequest)
            if let value = response.data {
                let converted = JSON(value)
                data(converted)
            }
        case .failure(let error):
            print(error)
            data(JSON())
            }
        }
    }
    
}
