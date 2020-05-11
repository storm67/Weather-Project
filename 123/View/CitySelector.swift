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

final class CitySelector: UIViewController, UITableViewDelegate,  UISearchBarDelegate , TagListViewDelegate {

    fileprivate var citySelectorVM = CitySelectorViewModel(manager: NetworkService())
    fileprivate var selectionVM = Selected()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
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
        view.addSubview(locationButton)
        addTag()
        reload()
        navigationController?.isNavigationBarHidden = true
        tableView.rowHeight = 52
        locationButton.topAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
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
        searchBar.text = nil
        if selectionVM.createData(name: selected.name, key: selected.key) {
            selectionVM.fetchData { (item) in
                print("\(item) selector")
            }
        navigationController?.pushViewController(PageViewController(), animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        checkActive()
        citySelectorVM.checkCity(by: searchText, completion: {
        self.reload()
        })
    }
    
    func checkActive() {
        guard let text = searchBar.text?.count else { return }
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
        tagListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        tagListView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 10).isActive = true
        tagListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tagListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250).isActive = true
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
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}




