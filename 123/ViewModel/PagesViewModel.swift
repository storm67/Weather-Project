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
    let pageMainView = PageViewController()
    
    var pages: [UIViewController] {
        get {
            return pageMainView.pages
        }
        set {
            pageMainView.pages = newValue
        }
    }
    
    
}
