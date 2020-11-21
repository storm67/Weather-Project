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
    
    var back = BackgroundView()
    
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
        view().collection.delegate = self
        view().collection.dataSource = self
        update()
        let char = ChartSeries(data: [(x: 0, y: 0),
                                      (x: 3, y: 4),
                                      (x: 4, y: 2),
                                      (x: 5, y: 2.3),
                                      (x: 7, y: 3),
                                      (x: 8, y: 2.2),
                                      (x: 9, y: 2.5)])
        char.area = true
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
            DispatchQueue.main.async {
                if model.lat == nil {
            self?.view().updateData("\(one.temperature.convertToCelsius())°","\(one.dayIconPhrase)", "Текущее местоположение", (self?.back.random())!)
                } else {
                    self?.view().updateData("\(one.temperature.convertToCelsius())°", "\(one.dayIconPhrase)", model.name, (self?.back.random())!)
                    self?.view().locationIcon.isHidden = true
                }
                self?.weather = weather
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return view().headerView
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 250)
    }
    
    
}
