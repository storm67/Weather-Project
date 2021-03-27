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
        myTableView.separatorColor = .white
        myTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myTableView.rowHeight = 125
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.register(PagesViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.separatorInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        return myTableView
    }()
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barTintColor = .white
        toolbar.backgroundColor = .orange
        toolbar.tintColor = .white
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    let editingButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage.init(systemName:"ellipsis")?.withTintColor(.black, renderingMode: .alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(editNow), for: .touchUpInside)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage.init(systemName:"plus")?.withTintColor(.black, renderingMode: .alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(getNewCity), for: .touchUpInside)
        return button
    }()
    
    let getBackButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage.init(systemName:"arrow.left")?.withTintColor(.black, renderingMode: .alwaysTemplate), for: .normal)
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
        toolbar.addSubview(addButton)
        toolbar.addSubview(getBackButton)
        toolbar.addSubview(editingButton)
        NSLayoutConstraint.activate([
            getBackButton.leftAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.leftAnchor, constant: 5),
            getBackButton.topAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.topAnchor, constant: 0),
            getBackButton.rightAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.rightAnchor, constant: -290),
            getBackButton.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: 0),
            editingButton.leftAnchor.constraint(equalTo: toolbar.leftAnchor, constant: 50),
            editingButton.topAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingButton.rightAnchor.constraint(equalTo: toolbar.rightAnchor, constant: -255),
            editingButton.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: -10),
            toolbar.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            toolbar.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            toolbar.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            toolbar.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            addButton.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor, constant: 280),
            addButton.topAnchor.constraint(equalTo: toolbar.safeAreaLayoutGuide.topAnchor, constant: 0),
            addButton.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: 0),
            addButton.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor, constant: 0)
        ])
        layer.masksToBounds = true
        layer.cornerRadius = 15
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
