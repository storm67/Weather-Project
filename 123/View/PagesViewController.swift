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
    
    public var viewModel: PageManagerProtocol!
    
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
        let vc = storyboard?.instantiateViewController(identifier: "CitySelector") as! CitySelector
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addPrimitiveData() {
        viewModel.rearrange {
            DispatchQueue.main.async {
                self.view().tableView.reloadData()
            }
        }
    }
    
    func throwsEdit() {
        view().tableView.isEditing = !view().tableView.isEditing
        switch view().tableView.isEditing {
        case true:
            view().editingButton.setTitle("Сохранить", for: .normal)
        case false:
            view().editingButton.setTitle("Изменить", for: .normal)
        }
    }
    
    func getBack() {
        navigationController?.popViewController(animated: true)
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PagesViewCell
        cell.viewModel = viewModel.cellViewerModel(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = viewModel.model()[sourceIndexPath.row]
        viewModel.refresh(sourceIndexPath, item, destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

