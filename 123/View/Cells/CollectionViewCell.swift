//
//  CollectionViewCell.swift
//  123
//
//  Created by Andrey on 20/11/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imgView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "13")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "15°"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func layout() {
//        contentView.addSubview(tempLabel)
//        contentView.addSubview(imgView)
        NSLayoutConstraint.activate([
//        imgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
//        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//        imgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
//        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
//        tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
//        tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
//        tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
//        tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.contentView.layer.borderWidth = 0
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    var viewModel: Convertible? {
        didSet {
            guard let viewModel = viewModel else { return }
            DispatchQueue.main.async {
                self.tempLabel.text = "\(viewModel.temperature)°"
                self.imgView.switchImage(viewModel.dayIconPhrase)
            }
        }
    }
}
