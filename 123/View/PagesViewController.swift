//
//  PagesViewController.swift
//  123
//
//  Created by gdml on 05/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class PagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let viewModel = PagesViewModel()
    fileprivate let selected = Selected()
    fileprivate var simpleModel: [City] = []
    
    
    let tableView: UITableView = {
        var myTableView = UITableView()
        myTableView.separatorColor = .black
        myTableView.rowHeight = 52
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.rowHeight = 57.0
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        return myTableView
    }()
    
    let editingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Edit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(editNow), for: .touchUpInside)
        return button
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
        super.viewDidLoad()
        tableView.register(PagesViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(editingButton)
        addPrimitiveData()
        layout()
    }
    
    func layout() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 330).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 620).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func getNewCity() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func editNow() {
        tableView.isEditing = !tableView.isEditing
        switch tableView.isEditing {
        case true:
            editingButton.setTitle("Done", for: .normal)
        case false:
            editingButton.setTitle("Edit", for: .normal)
        }
    }
    
    func addPrimitiveData() {
        selected.resetable {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selected.city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PagesViewCell
        cell.viewModel = selected.cellViewModel(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = selected.city[sourceIndexPath.row]
        selected.city.remove(at: sourceIndexPath.row)
        selected.city.insert(item, at: destinationIndexPath.row)
        for (index, name) in selected.city.enumerated() {
            name.position = Double(index)
        }
            DispatchQueue.main.async {
                self.tableView.reloadData()
        }
    }
}


