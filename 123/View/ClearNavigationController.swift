//
//  ClearNavigationController.swift
//  123
//
//  Created by Storm67 on 19/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import UIKit

class ClearNavigationController: UIViewController, Reciever {
    
    func view() -> GradientView {
        return view as! GradientView
    }
    
    var viewModel: LocationInterfaceProtocol!
    weak var detector: NavigationBackDetector?
    
    override func loadView() {
        super.loadView()
        view = GradientView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
    }
    
    
    func getTrigger() {
        viewModel.getLocation()
        viewModel.setLocation { [weak self] (location, name, error, _) in
            guard location != nil else { return }
            let timeZoneOffset = TimeZone.current.secondsFromGMT() / 3600
            self?.viewModel.createFromLocation(name: name, lat: location?.latitude, lon: location?.longitude, timeZone: timeZoneOffset)
            guard let access = self?.viewModel.checkAccess(access: true) else { return }
            if access {
                self?.dismiss(animated: true) {
                    guard let present = self?.navigationController?.presentedViewController as? PageViewController else { return }
                    present.toStart()
                    present.pages[0].unhide()
                }
            }
        }
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
