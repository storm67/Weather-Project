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
    
    var mainImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
    }()
    
    var viewModel: PageCellModel? {
        didSet {
            guard let viewModel = viewModel, let temp = viewModel.temp else { return }
            //mainImage.anotherSwitchImage(viewModel.date.current())
            textLabel?.text = viewModel.name
            detailTextLabel?.text = "\(Int().returnTime(time: viewModel.date, interval: .base))"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        layout()
        backgroundColor = .white
    }
    
    fileprivate func layout() {
        contentView.addSubview(mainImage)
        NSLayoutConstraint.activate([
        mainImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
        mainImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
        mainImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
        mainImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
