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
    
    let backView: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    var imgView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cloud")?.imageResize(sizeChange: CGSize(width: 32,height: 32))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "15°"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var maskLayer: UIView = {
        let image = UIView()
        image.clipsToBounds = true
        image.backgroundColor = .none
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func layout() {
        backView.addSubview(tempLabel)
        backView.addSubview(maskLayer)
        addSubview(imgView)
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        backgroundColor = .clear
        contentView.backgroundColor = .white
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
                let back = BackgroundView()
                self.tempLabel.text = "\(viewModel.temperature)°"
                self.imgView.image = back.switchImage(self.imgView, viewModel.dayIconPhrase)
                print(self.viewModel?.dayIconPhrase as Any)
            }
        }
    }
}
