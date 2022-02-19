//
//  ViewController.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit
import SkeletonView

final class MainViewController: UIViewController {
    
    func view() -> MainControllerView {
        return view as! MainControllerView
    }
        
    fileprivate var simpleModel: SimpleModel?
    public var viewModel: ViewModelProtocol!
    
    override func loadView() {
        view = MainControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view().tableView.dataSource = self
        view().tableView.delegate = self
        view().scrollView.delegate = self
        update()
//        view().charts.data = [10,11,6,0]
        DispatchQueue.main.async {
            self.view().hasUnloaded()
        }
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
                self?.viewModel.weather = weather
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
                    if model.key == .zero {
                    guard let lat = model.lat,
                          let lon = model.lon
                          else { return }
                    self?.viewModel.getKeyByLocation(lat, lon, {
                        self?.viewModel.lastHoursWeather(key: $0, completion: { array in
                            DispatchQueue.main.async {
                                self?.view().chartsIntegrator(array)
                            }
                        })
                    })
                    } else {
                    guard let key = model.key else { return }
                        self?.viewModel.lastHoursWeather(key: key, completion: { array in
                            DispatchQueue.main.async {
                                self?.view().chartsIntegrator(array)
                            }
                        })
                    }
                }
            }
        )
    }
    
}



extension MainViewController: SkeletonTableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.viewModel = viewModel.cellViewModel(index: indexPath.row)
        guard let simple = simpleModel else { return cell }
        if simple.key == 0 && simple.key == nil && simple.name.isEmpty {
        cell.showAnimatedGradientSkeleton()
        cell.layoutSkeletonIfNeeded()
        }
        return cell
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
         return 3
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return viewModel.weather.count
//       }
//
//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
//           cell.viewModel = viewModel.cellViewModel(index: indexPath.row)
//           return cell
//       }
    

}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let directViewValue = view.bounds.height + scrollView.contentOffset.y
        print(directViewValue, view().sunlightStatus.frame.origin.y)
        if directViewValue >= view().sunlightStatus.frame.origin.y {
//            view().sunlightStatus.setCenter()
        }
    }
    
}
