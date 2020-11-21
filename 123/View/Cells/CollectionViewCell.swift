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
    override var frame: CGRect {
        get {
            return super.frame
        }
        
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.93 // get 80% width here
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            frame.origin.y += 5
            frame.size.height -= 2 * 5
            super.frame = frame
        }
        
    }
    
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
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func layout() {
        contentView.addSubview(backView)
        backView.addSubview(tempLabel)
        backView.addSubview(maskLayer)
        addSubview(imgView)
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            tempLabel.leadingAnchor.constraint(lessThanOrEqualTo: contentView.leadingAnchor, constant: 335),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 265),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            maskLayer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34),
            maskLayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 270),
            maskLayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -75),
            maskLayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
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
//                self.textLabel?.text = "\(viewModel.date)"
                self.tempLabel.text = "\(viewModel.temperature.convertToCelsius())°"
//                self.detailTextLabel?.text = viewModel.standardDate
                self.imgView.image = back.switchImage(self.imgView, viewModel.dayIconPhrase)
            }
        }
    }
}
