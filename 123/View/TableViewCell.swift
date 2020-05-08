//
//  TableViewCell.swift
//  123
//
//  Created by gdml on 01/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    let back = BackgroundView()
    
    let imgView: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "weather")?.imageResize(sizeChange: CGSize(width: 32,height: 32))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "15°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgView)
        contentView.addSubview(tempLabel)
        tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 330).isActive = true
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 240).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    weak var viewModel: Convertible? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = "\(viewModel.date)"
            tempLabel.text = "\(viewModel.temperature.convertToCelsius())°"
            detailTextLabel?.text = viewModel.standardDate
            imgView.image = back.switchImage(viewModel.dayIcon)
        }
    }

}
