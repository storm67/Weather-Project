//
//  PagesViewController.swift
//  123
//
//  Created by gdml on 05/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class PagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    fileprivate let viewModel = PagesViewModel()
    
    let tableView: UITableView! = {
        var myTableView = UITableView()
        myTableView.separatorColor = .black
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.rowHeight = 57.0
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        return myTableView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(getNewCity), for: .touchUpInside)
        return button
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = addButton.frame.height/2
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(addButton)
        layout()
    }
    
    func layout() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.separatorColor = .black
        tableView.rowHeight = 52
        addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 330).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 620).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func getNewCity() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hello"
        return cell
    }
    
}

