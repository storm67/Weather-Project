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
    fileprivate let selectionVM = Selected()
    public var viewModel: MainControllerViewModel? = MainControllerViewModel(data: NetworkService())
    
    fileprivate var myTableView: UITableView! = {
        var myTableView = UITableView()
        myTableView.separatorColor = .white
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.rowHeight = 57.0
        myTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.isScrollEnabled = false
        return myTableView
    }()
    
    override func loadView() {
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        location()
        update()
        layout()
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
            self?.view().updateData("\(one.temperature)°", model.name)
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
    
    public func layout() {
        view.addSubview(myTableView)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        myTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 355.0).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true
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
    
    
}
