//
//  PagesViewController.swift
//  123
//
//  Created by gdml on 05/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class PagesViewController: UIViewController {
    
    var table: UITableView = {
        var table = UITableView()
        return table
    }()
    
    
    override func viewDidLoad() {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(getNewCity), for: .touchUpInside)
        self.view.addSubview(button)
        view.clipsToBounds = true
    }
    
    
    func setFrame() {
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        table = UITableView(frame: CGRect(x: 0, y: height, width: view.frame.width, height: view.frame.height))
        view.addSubview(table)
    }
    @objc func getNewCity() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    //
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return 3
    //       }
    //
    //       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    //
    //       }
    
}
