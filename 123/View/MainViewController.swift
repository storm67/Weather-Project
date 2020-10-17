//
//  ViewController.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit
import Swinject
import SwiftChart
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
        view().myTableView.dataSource = self
        view().myTableView.delegate = self
        update()
        let char = ChartSeries([3])
        view().charts.add(char)
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
        viewModel.newDebug(key: model.key, lat: model.lat, lon: model.lon, completion: { [weak self] weather, one in
            if model.lat == nil {
            self?.view().updateData("\(one.temperature)°","\(one.dayIconPhrase), Ощущается как \(one.realFeel)°", "Current Location")
            } else {
            self?.view().updateData("\(one.temperature)°", "\(one.dayIconPhrase), ощущается как \(one.realFeel)°", model.name)
                self?.view().locationIcon.isHidden = true
            }
            DispatchQueue.main.async {
                self?.weather = weather
                self?.view().myTableView.reloadData()
            }
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.viewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return view().headerView
    }
    
}
