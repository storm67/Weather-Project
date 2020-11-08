//
//  PagesViewCell.swift
//  123
//
//  Created by gdml on 11/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class PagesViewCell: UITableViewCell {
    
    var name: UILabel = {
    let text = UILabel()
    text.textColor = .black
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
    }()
    
    
    var viewModel: City! {
        didSet {
            guard let viewModel = viewModel else { return }
            name.text = viewModel.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    fileprivate func layout() {
        contentView.addSubview(name)
        NSLayoutConstraint.activate([
        name.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: -70),
        name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
        name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
