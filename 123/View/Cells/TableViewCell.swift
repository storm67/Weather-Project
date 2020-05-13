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
    
    let imgView: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "cloud")?.imageResize(sizeChange: CGSize(width: 32,height: 32))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "15°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backView)
        backView.addSubview(imgView)
        backView.addSubview(tempLabel)
        backgroundColor = .clear

       self.contentView.layer.cornerRadius = 2.0
       self.contentView.layer.borderWidth = 1.0
       self.contentView.layer.borderColor = UIColor.clear.cgColor
       self.contentView.layer.masksToBounds = true

       
       self.layer.masksToBounds = false
       self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 285).isActive = true
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 220).isActive = true
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -78).isActive = true

        
        backgroundColor = .clear
        

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
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