//
//  LayerViewController.swift
//  123
//
//  Created by Storm67 on 08/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class LayerViewController: UIViewController {
    var page: UIPageViewController!
    
    override func viewDidLoad() {
        page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil) as? PageViewController
        addChild(page)
        view.addSubview(page.view)
    }
    
}
