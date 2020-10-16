//
//  CitySelector.swift
//  PizdecProject
//
//  Created by gdml on 04/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation


import UIKit
import TagListView

final class CitySelector: UIViewController, UITableViewDelegate,  UISearchBarDelegate, UISearchResultsUpdating, TagListViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    var viewModel: CitySelectorProtocol! 
    
    let tagListView: TagListView = {
        let view = TagListView()
        view.tagBackgroundColor = #colorLiteral(red: 0.92261606, green: 0.92261606, blue: 0.92261606, alpha: 1)
        view.textColor = .black
        view.textFont = view.textFont.withSize(14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationButton: UILabel = {
        let button = UILabel()
        button.text = "Популярные города"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.font = UIFont.init(name: "Arial", size: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        addTag()
        layout()
    }
    
   required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CitySelector: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectorViewModel.cellID) as? CellView {
            cell.viewModel = self.viewModel.cellViewModel(index: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.searchElements[indexPath.row]
        searchController.searchBar.text = nil
        if viewModel.createData(name: selected.name) {
        let view = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        checkActive()
        viewModel.checkCity(by: text, completion: {
            self.reload()
        })
    }
    
    func tagPressed(_ title: String, _ number: Int, tagView: TagView, sender: TagListView) {
        guard number != 0 else { return }
        if viewModel.createDataFromTag(name: title, key: number) {
        let view = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        navigationController?.pushViewController(view, animated: true)
        }
        tagView.isSelected = !tagView.isSelected
    }
    
    func checkActive() {
        guard let text = searchController.searchBar.text?.count else { return }
        if text >= 1 {
            locationButton.isHidden = true
            tagListView.isHidden = true
        } else {
            locationButton.isHidden = false
            tagListView.isHidden = false
        }
    }
    func addTag() {
        view.addSubview(tagListView)
        view.addSubview(locationButton)
        guard let image = UIImage(named: "nav")?.imageResize(sizeChange: CGSize(width: 16, height: 16)) else { return }
        tagListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11).isActive = true
        tagListView.topAnchor.constraint(equalTo: locationButton.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tagListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7).isActive = true
        tagListView.heightAnchor.constraint(equalToConstant: 310).isActive = true
        tagListView.delegate = self
        tagListView.paddingY = 10
        tagListView.marginY = 8
        tagListView.marginX = 8
        tagListView.cornerRadius = 5
        tagListView.imageEdge = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        tagListView.delegate = self
        tagListView.addTagWithImage("  Location  ", image).onTap = { [weak self] _ in
        self?.getLocation()
        }
        tagListView.paddingX = 4
        tagListView.imagePaddingX = 0
        tagListView.addTags(Defaults.dictionary)
    }
    func configureSearchController() {
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundColor = .white
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.delegate = self
        view.addSubview(locationButton)
    }
    func layout() {
        tableView.clipsToBounds = true
        tableView.rowHeight = 52
        locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11).isActive = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func getLocation() {
        viewModel.getLocation()
        viewModel.setLocation { [weak self] (location, name, error) in
        guard location != nil else { return }
        _ = self?.viewModel.createFromLocation(name: name, lat: location?.latitude, lon: location?.longitude)
        guard let access = self?.viewModel.checkAccess(access: true) else { return }
        if access {
            let view = self?.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            self?.navigationController?.pushViewController(view, animated: true)
        }
    }
}
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



