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

final class CitySelector: UIViewController, UITableViewDelegate,  UISearchBarDelegate , UISearchResultsUpdating, TagListViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var citySelectorVM = CitySelectorViewModel(manager: NetworkService())
    fileprivate var selectionVM = Selected()
    
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
        button.text = "Popular places"
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
}

extension CitySelector: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citySelectorVM.searchElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectorViewModel.cellID) as? CellView {
            cell.viewModel = self.citySelectorVM.cellViewModel(index: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = citySelectorVM.searchElements[indexPath.row]
        searchController.searchBar.text = nil
        if selectionVM.createData(name: selected.name, key: selected.key, lat: nil, lon: nil) {
        navigationController?.pushViewController(PageViewController(), animated: true)
        dismiss(animated: true, completion: nil)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        checkActive()
        citySelectorVM.checkCity(by: text, completion: {
            self.reload()
        })
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
        guard let image = UIImage(named: "nav")?.imageResize(sizeChange: CGSize(width: 16, height: 16)) else { return }
        view.addSubview(tagListView)
        view.addSubview(locationButton)
        tagListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        tagListView.topAnchor.constraint(equalTo: locationButton.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tagListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tagListView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        tagListView.delegate = self
        tagListView.paddingY = 10
        tagListView.marginY = 8
        tagListView.marginX = 8
        tagListView.cornerRadius = 5
        tagListView.imageEdge = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        tagListView.sizeToFit()
        tagListView.addTagWithImage("  Location  ", image).onTap = { [weak self] _ in
            self?.getLocation()
        }
        tagListView.paddingX = 4
        tagListView.imagePaddingX = 0
        tagListView.addTags(["Saint Petersburg","Los Angeles","Tashkent","Tallin","Kiev","Ashkabad","Moscow","Voronezh","Volgograd","Kazan","Ekaterinburg","Rostov-on-Don","Perm","Omsk","Novosibirsk","Nizhniy Novgorod","Krasnoyarsk","Chelyabinsk","Ufa","Samara","Minsk","Baku","Vilnus","Riga"])
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
        tableView.rowHeight = 52
        locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11).isActive = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func getLocation() {
        LocationManager.locator.requestLocation()
        LocationManager.locator.getLocation { [weak self] (location, name, error)  in
        guard location != nil else { return }
        _ = self?.selectionVM.createData(name: name, key: nil, lat: location?.latitude, lon: location?.longitude)
        LocationManager.locator.data = true
        guard LocationManager.locator.access else { return }
        guard LocationManager.locator.data else { return }
        self?.navigationController?.pushViewController(PageViewController(), animated: true)
        }
        
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}




