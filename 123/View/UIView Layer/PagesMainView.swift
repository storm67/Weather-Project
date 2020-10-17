//
//  PagesMainView.swift
//  123
//
//  Created by gdml on 17/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit
import SwiftChart

final class PagesMainView: UIView {
    
    weak var delegate: GetEdit?
    
    let tableView: UITableView = {
           var myTableView = UITableView()
           myTableView.separatorColor = .black
           myTableView.rowHeight = 52
           myTableView.tableFooterView = UIView(frame: .zero)
           myTableView.rowHeight = 57.0
           myTableView.register(PagesViewCell.self, forCellReuseIdentifier: "cell")
           myTableView.translatesAutoresizingMaskIntoConstraints = false
           return myTableView
       }()
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barTintColor = .black
        toolbar.backgroundColor = .orange
        toolbar.tintColor = .white
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    let editingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Edit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(editNow), for: .touchUpInside)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
    button.setImage(UIImage.init(systemName:"plus.square.on.square")?.imageResize(sizeChange: CGSize(width: 33, height: 33)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(getNewCity), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height/2
        return button
    }()
    
    let getBackButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
    button.setImage(UIImage.init(systemName:"arrowtriangle.right.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(getBackCity), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height/2
        return button
    }()
    
    func layout() {
        addSubview(toolbar)
        addSubview(tableView)
        tableView.addSubview(addButton)
        toolbar.addSubview(getBackButton)
        toolbar.addSubview(editingButton)
        getBackButton.leftAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.leftAnchor, constant: 320).isActive = true
        getBackButton.topAnchor.constraint(equalTo: toolbar.topAnchor, constant: 0).isActive = true
        getBackButton.rightAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        getBackButton.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: 0).isActive = true
        editingButton.leftAnchor.constraint(equalTo: toolbar.leftAnchor, constant: 10).isActive = true
        editingButton.topAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        editingButton.rightAnchor.constraint(equalTo: toolbar.rightAnchor, constant: -320).isActive = true
        editingButton.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: -10).isActive = true
        toolbar.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        toolbar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        toolbar.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        addButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 325).isActive = true
        addButton.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 560).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getBackCity() {
        delegate?.getBack()
    }
    
    @objc func editNow() {
        delegate?.throwsEdit()
    }
    
    @objc func getNewCity() {
        delegate?.getNewCity()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = .white
    }
}
