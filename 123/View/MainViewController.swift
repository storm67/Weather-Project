//
//  ViewController.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit
import Swinject

final class MainViewController: UIViewController {
    
    fileprivate func view() -> MainControllerView {
        return view as! MainControllerView
    }
    
    fileprivate var simpleModel: SimpleModel?
    fileprivate var weather = [Convertible]()
    public var viewModel: ViewModelProtocol!
    
    override func loadView() {
        view = MainControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view().tableView.dataSource = self
        view().tableView.delegate = self
        update()
    }
    
    convenience init(model: SimpleModel, viewModel: ViewModelProtocol) {
        self.init()
        self.simpleModel = model
        self.viewModel = viewModel
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
        edgesForExtendedLayout = []
    }
    
    fileprivate func update() {
        guard let model = simpleModel else { return }
        viewModel.newDebug(key: model.key, lat: model.lat, lon: model.lon, completion: { [weak self] weather, one, quality in
            DispatchQueue.main.async {
                var pvc = [String : Convertible]()
                pvc = ["path" : one]
                self?.weather = weather
                self?.view().tableView.reloadData()
                NotificationCenter.default.post(name: NSNotification.Name.notify, object: nil, userInfo: pvc)
                self?.view().updateData(one.dayIconPhrase,
                    "\(one.dayIconPhrase)",
                    model.name,
                    one.air,
                    quality[0].value,
                    one.temperature,
                    one.sunrise,
                    one.sunset,
                    model.timeZone,
                    one.wind,
                    3,
                    one.humidity,
                    one.direction)
                self?.view().locationIcon.isHidden = true
                self?.view().tableView.reloadData()
            }
            }
        )}
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.viewModel = viewModel.cellViewModel(index: indexPath.row)
        return cell
    }
    
}
