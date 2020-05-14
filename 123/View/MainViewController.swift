//
//  ViewController.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    fileprivate func view() -> CustomView {
        return view as! CustomView
    }
    
    fileprivate let back = BackgroundView()
    fileprivate var simpleModel: SimpleModel?
    fileprivate var weather = [Convertible]()
    fileprivate let selectionVM = Selected()
    public var viewModel: MainControllerViewModel? = MainControllerViewModel(data: NetworkService())
    
    fileprivate var myTableView: UITableView! = {
        var myTableView = UITableView()
        myTableView.separatorColor = .white
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.backgroundColor = .purple
        myTableView.rowHeight = 57.0
        myTableView.sectionHeaderHeight = 100
        myTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.layer.cornerRadius = 5
        myTableView.layer.masksToBounds = true
        myTableView.isScrollEnabled = false
        return myTableView
    }()
    
    override func loadView() {
        view = CustomView()
        view.setNeedsDisplay()
        view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        update()
    }
    
    convenience init(model: SimpleModel) {
        self.init()
        self.simpleModel = model
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
        edgesForExtendedLayout = []
    }
    
    fileprivate func update() {
        guard let model = simpleModel else { return }
        viewModel?.newDebug(key: model.key, lat: model.lat, lon: model.lon, completion: { [weak self] weather, one in
            if model.lat != nil {
            self?.view().updateData("\(one.temperature)°","\(one.dayIconPhrase), Ощущается как \(one.realFeel)°", "Current Location")
            } else {
            self?.view().updateData("\(one.temperature)°", "\(one.dayIconPhrase), ощущается как \(one.realFeel)°", model.name)
                self?.view().locationIcon.isHidden = true
            }
            DispatchQueue.main.async {
                self?.weather = weather
                self?.myTableView.reloadData()
            }
        })
    }
  
    public func layout() {
        view().scrollView.addSubview(myTableView)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.centerXAnchor.constraint(equalTo: view().scrollView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        myTableView.topAnchor.constraint(equalTo: view().imageView.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        myTableView.widthAnchor.constraint(equalToConstant: 355).isActive = true
        myTableView.heightAnchor.constraint(equalToConstant: 400).isActive = true
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return view().headerView
    }
    
}
