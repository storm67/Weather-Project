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
        navigationController?.isNavigationBarHidden = true
        view().delegate = self
        view().tableView.dataSource = self
        view().tableView.delegate = self
        modalPresentationStyle = .fullScreen
        view().tableView.dragDelegate = self
        view().tableView.dropDelegate = self
        view().tableView.dragInteractionEnabled = true
    }
    
    func getNewCity() {
        let vc = storyboard?.instantiateViewController(identifier: "CitySelector") as! CitySelector
        guard let controller = self.navigationController, let topView = controller.topViewController else { return }
        topView.dismiss(animated: true, completion: nil)
        controller.pushViewController(vc, animated: true)
    }
    
    func addPrimitiveData() {
        viewModel.add()
        viewModel.rearrange {
            DispatchQueue.main.async {
                self.view().tableView.reloadData()
            }
        }
    }

    
    func getBack() {
        guard let controller = self.navigationController, let topView = controller.topViewController else { return }
        topView.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PagesViewCell
        cell.viewModel = viewModel.cellViewModel(indexPath.row)
        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.delete(indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func dragItem(for indexPath: IndexPath) -> UIDragItem {
        let prefectureName = viewModel.pages[indexPath.row]
        let itemProvider = NSItemProvider(object: prefectureName)
        return UIDragItem(itemProvider: itemProvider)
    }
 
}

extension PagesViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [dragItem(for: indexPath)]
    }
}

extension PagesViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let item = coordinator.items.first,
            let destinationIndexPath = coordinator.destinationIndexPath,
            let sourceIndexPath = item.sourceIndexPath else { return }

        tableView.performBatchUpdates({ [weak self] in
            self?.viewModel.refresh(sourceIndexPath, destinationIndexPath)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            }, completion: nil)
        coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
    }
    
}
