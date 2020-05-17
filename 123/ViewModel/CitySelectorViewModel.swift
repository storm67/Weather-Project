//
//  ViewModel.swift
//  PizdecProject
//
//  Created by gdml on 04/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

final class CitySelectorViewModel {
    private var weatherManager: NetworkService
    private(set) var searchElements = [CellViewModel]()
    static let cellID = "cell"
    
    func checkCity(by searchText: String, completion: @escaping () -> Void) {
        
        let initIt = Test(str: searchText, key: nil, lat: nil, lon: nil)
        let Operator = Init(test: initIt)
        
        weatherManager.request(router: Operator.getCities()) { [weak self] data in
            let converted = JSON(data).arrayValue
            let cvm = converted.map { CityModel(mod: $0) }
            let vvm = cvm.map { CellViewModel(reg: $0) }
            self?.searchElements = vvm
            completion()
        }
    }
    
    func cellViewModel(index: Int) -> CellViewModel? {
        guard index < searchElements.count else { return nil }
        return searchElements[index]
    }
    
    init(manager: NetworkService) {
        self.weatherManager = manager
    }
}
