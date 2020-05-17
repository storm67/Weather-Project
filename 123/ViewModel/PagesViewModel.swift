//
//  CitiesData.swift
//  123
//
//  Created by gdml on 13/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class PagesViewModel: UIViewController {
    
    
    var pages = [City]()
    
    
    func cellViewModel(index: Int) -> City? {
        guard index < pages.count else { return nil }
        return pages[index]
    }
}

