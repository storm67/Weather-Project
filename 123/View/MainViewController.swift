//
//  ViewController.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit
import CoreLocation


final class ViewController: UIViewController, MyViewDelegate {
    
    fileprivate func view() -> CustomView {
        return view as! CustomView
    }
    
    fileprivate var simpleModel: SimpleModel?
    fileprivate var weather = [Convertible]()
    fileprivate let selectionVM = Selected()
    public var viewModel: MainControllerViewModel? = MainControllerViewModel(data: NetworkService())
    
    fileprivate var myTableView: UITableView! = {
        var myTableView = UITableView()
        myTableView = UITableView(frame: CGRect(x: 0, y: 365, width: 355, height: 230))
        myTableView.alwaysBounceVertical = false
        myTableView.separatorColor = .white
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.rowHeight = 57.0
        myTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        return myTableView
    }()
    
    override func loadView() {
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        view().addSubview(myTableView)
        myTableView.dataSource = self
        myTableView.delegate = self
        location()
        update()
    }
    
    convenience init(model: SimpleModel) {
        self.init()
        self.simpleModel = model
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
        edgesForExtendedLayout = []
    }
    @IBAction func del(_ sender: Any) {
        switchVC()
    }
    
    fileprivate func update() {
        guard let model = simpleModel else { return }
        viewModel?.weatherFiveDayRequest(key: Int(model.key)) { [weak self] weather, one in
            self?.view().updateData(temp: "\(one.temperature)°")
            DispatchQueue.main.async {
                self?.weather = weather
                self?.myTableView.reloadData()
            }
        }
    }
    
    fileprivate func switchVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? CitySelector
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    fileprivate func location() {
        self.viewModel?.completion = { [weak self] item, one in
            self?.weather = item
        }
    }
    
    public func didTapButton() {
        self.navigationController?.pushViewController(PagesViewController(), animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case CLAuthorizationStatus.denied, CLAuthorizationStatus.notDetermined, CLAuthorizationStatus.restricted:
            switchVC()
        default:
            break
        }
        
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.viewModel = viewModel?.cellViewModel(index: indexPath.row)
        return cell
    }
    
    
}
