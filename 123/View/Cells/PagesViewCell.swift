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
    
    override var frame: CGRect {
        
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.98 // get 80% width here
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            frame.size.height -= 2 * 2
            super.frame = frame
        }
    }
    
    var name: UILabel = {
    let text = UILabel()
    text.textColor = .white
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
    }()
    
    var imgView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    image.layer.masksToBounds = true
    return image
    }()
    
    var viewModel: City! {
        didSet {
            guard let viewModel = viewModel else { return }
            name.text = viewModel.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        layout()
        backgroundColor = .white
    }
    
    fileprivate func layout() {
        let back = BackgroundView()
        contentView.addSubview(imgView)
        contentView.addSubview(name)
        NSLayoutConstraint.activate([
        imgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
        imgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        name.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: -70),
        name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
        name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30)
        ])
        imgView.image = back.random()
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
