//
//  ViewController.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, MyViewDelegate {
   
    fileprivate func view() -> CustomView {
        return view as! CustomView
    }
    fileprivate var simpleModel: SimpleModel?
    fileprivate var weather = [Convertible]()
    public var viewModel: MainControllerViewModel? = MainControllerViewModel(data: NetworkService())
    
    lazy var myTableView: UITableView = {
        var myTableView = UITableView()
        myTableView = UITableView(frame: CGRect(x: 0, y: 365, width: 365, height: 230))
        myTableView.separatorColor = .white
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.alwaysBounceVertical = false
        myTableView.isScrollEnabled = false
        myTableView.rowHeight = 57.0
        myTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        return myTableView
    }()
    
    override func loadView() {
        view = CustomView()
        location()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        view().addSubview(myTableView)         
        myTableView.dataSource = self
        myTableView.delegate = self
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
        guard LocationManager.locator.selected == false else { return }
        print("update()")
        viewModel?.weatherFiveDayRequest(key: model.key) { [unowned self] weather, one in
            self.view().cityLabel.text = model.name
            self.weather = weather
            self.view().updateData(temp: "\(one.temperature)°")
            DispatchQueue.main.async {
                self.weather = weather
                self.myTableView.reloadData()
            }
        }
    }
    
    fileprivate func switchVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? CitySelector
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    fileprivate func location() {
        guard let model = simpleModel else { return }
        guard LocationManager.locator.selected else { return }
        print("location()")
        self.viewModel?.byLocation(lat: model.lat, lon: model.lon, { [weak self] (first, second) in
            self?.view().cityLabel.text = model.name
            print(model.lat)
            print(first,second)
            self?.weather = first
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
            }
        })
    }
    
    public func didTapButton() {
        self.navigationController?.pushViewController(PagesViewController(), animated: true)
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
