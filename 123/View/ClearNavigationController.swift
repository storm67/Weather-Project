//
//  ClearNavigationController.swift
//  123
//
//  Created by Storm67 on 19/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import UIKit

class ClearNavigationController: UIViewController {
    
    func view() -> GradientView {
        return view as! GradientView
    }
    
    override func loadView() {
        super.loadView()
        view = GradientView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

class ClearController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Текущее местоположение"
        label.textColor = .black
        view.addSubview(label)
        NSLayoutConstraint.activate([
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
