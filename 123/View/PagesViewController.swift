//
//  PagesViewController.swift
//  123
//
//  Created by gdml on 05/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol GetEdit: class {
    func throwsEdit()
    func getBack()
    func getNewCity()
}

final class PagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GetEdit {
    
    fileprivate func view() -> PagesMainView {
        return view as! PagesMainView
    }
    
    fileprivate let viewModel = PagesViewModel()
    fileprivate let selected = CoreDataManager()
    
    override func loadView() {
        view = PagesMainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPrimitiveData()
        view().delegate = self
        view().tableView.dataSource = self
        view().tableView.delegate = self
    }
    
    func getNewCity() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func addPrimitiveData() {
        selected.resetable {
            DispatchQueue.main.async {
                self.view().tableView.reloadData()
            }
        }
    }
    
    func throwsEdit() {
        view().tableView.isEditing = !view().tableView.isEditing
        switch view().tableView.isEditing {
        case true:
            view().editingButton.setTitle("Done", for: .normal)
        case false:
            view().editingButton.setTitle("Edit", for: .normal)
        }
    }
    
    func getBack() {
        navigationController?.popViewController(animated: true)
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
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selected.deleteData(indexPath: indexPath)
            selected.city.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

