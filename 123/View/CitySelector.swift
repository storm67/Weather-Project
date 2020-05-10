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

final class CitySelector: UIViewController, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate , TagListViewDelegate {

    fileprivate var citySelectorVM = CitySelectorViewModel(manager: NetworkService())
    fileprivate var selectionVM = Selected()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    var array: [Int] = []
    @IBOutlet weak var tableView: UITableView!
    
    let locationImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "nav")?.imageResize(sizeChange: CGSize(width: 666, height: 666))
        return view
    }()
    
    let tagListView: TagListView = {
        let view = TagListView()
        view.tagBackgroundColor = #colorLiteral(red: 0.92261606, green: 0.92261606, blue: 0.92261606, alpha: 1)
        view.textColor = .black
        view.textFont = view.textFont.withSize(14)
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
        view.addSubview(locationButton)
        addTag()
        reload()
        configureSearchController()
        navigationController?.isNavigationBarHidden = true
        tableView.rowHeight = 52
        locationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 76).isActive = true
        locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        array.append(selected.key)
        searchController.searchBar.text = nil
        if selectionVM.createData(name: selected.name, key: selected.key) {
            selectionVM.fetchData { (item) in
                print("\(item) selector")
            }
        navigationController?.pushViewController(PageViewController(), animated: true)
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
        tagListView.addSubview(locationImage)
        tagListView.frame = CGRect(x: 10, y: 100, width: 350, height: 300)
        view.addSubview(tagListView)
        tagListView.delegate = self
        tagListView.paddingY = 10
        tagListView.marginY = 8
        tagListView.marginX = 8
        tagListView.cornerRadius = 5
        tagListView.imageEdge = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        tagListView.addTagWithImage("  Location  ", image)
        tagListView.paddingX = 4
        tagListView.imagePaddingX = 0
        tagListView.addTag("Saint Petersburg")
        tagListView.addTag("Los Angeles")
        tagListView.addTag("Tashkent")
        tagListView.addTag("Tallin")
        tagListView.addTag("Kiev")
        tagListView.addTag("Ashkabad")
        tagListView.addTag("Moscow")
        tagListView.addTag("Voronezh")
        tagListView.addTag("Volgograd")
        tagListView.addTag("Kazan")
        tagListView.addTag("Ekaterinburg")
        tagListView.addTag("Rostov-on-Don")
        tagListView.addTag("Perm")
        tagListView.addTag("Omsk")
        tagListView.addTag("Novosibirsk")
        tagListView.addTag("Nizhniy Novgorod")
        tagListView.addTag("Krasnoyarsk")
        tagListView.addTag("Chelyabinsk")
        tagListView.addTag("Ufa")
        tagListView.addTag("Samara")
        tagListView.addTag("Minsk")
        tagListView.addTag("Baku")
        tagListView.addTag("Vilnus")
        tagListView.addTag("Riga")
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
    }
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}




