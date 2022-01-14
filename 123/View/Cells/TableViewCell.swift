//
//  TableViewCell.swift
//  123
//
//  Created by gdml on 01/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

final class CustomCell: UITableViewCell {
    
    let backView: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 23)
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondTemp: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 20)
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var maskLayer: UIView = {
        let image = UIView()
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imgView: UIImageView = {
      let image = UIImageView()
      image.contentMode = .scaleAspectFit
      image.translatesAutoresizingMaskIntoConstraints = false
      return image
      }()

    var separator: UIView = {
      let image = UIView()
      image.backgroundColor = .white
      image.translatesAutoresizingMaskIntoConstraints = false
      return image
      }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = .black
        detailTextLabel?.textColor = .black
        contentView.addSubview(backView)
        backView.addSubview(tempLabel)
        backView.addSubview(secondTemp)
        backView.addSubview(imgView)
        backView.addSubview(separator)
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        NSLayoutConstraint.activate([
        secondTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
        secondTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 235),
        secondTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -345),
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
        tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 210),
        tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -65),
        separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        separator.heightAnchor.constraint(equalToConstant: 2),
        separator.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        backgroundColor = #colorLiteral(red: 0.9043619633, green: 0.9659909606, blue: 0.9911366105, alpha: 1)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        createCircle()
        setNeedsDisplay()
        isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: Convertible? {
        didSet {
            guard let viewModel = viewModel else { return }
            DispatchQueue.main.async {
                self.textLabel?.text = "\(viewModel.date)"
                self.tempLabel.text = "\(viewModel.temperatureMax)°"
                self.secondTemp.text = "\(viewModel.temperature)°"
                self.detailTextLabel?.text = viewModel.standardDate
                self.imgView.switchImage(viewModel.dayIconPhrase)
            }
        }
    }
    
    func createCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 30, y: 37.5), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.opacity = 0.2
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        shapeLayer.lineWidth = 3.0
        backView.layer.insertSublayer(shapeLayer, at: 0)
    }
    
}
