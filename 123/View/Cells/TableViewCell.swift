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
    let back = BackgroundView()
    
    let backView: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "15°"
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 23)
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondTemp: UILabel = {
        let label = UILabel()
        label.text = "15°"
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
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        NSLayoutConstraint.activate([
        secondTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
        secondTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 235),
        secondTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -360),
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),
        tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
        tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 210),
        tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -65),
        ])
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        createCircle()
        setNeedsDisplay()
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
                self.imgView.image = self.back.switchImage(self.imgView, viewModel.dayIconPhrase)
                print(self.viewModel?.dayIconPhrase as Any)
                self.imgView.sizeToFit()
            }
        }
    }
    
    func createCircle() -> UIBezierPath {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 32, y: 46), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.opacity = 0.2
        shapeLayer.path = circlePath.cgPath
        // Change the fill color
        shapeLayer.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        // You can change the stroke color
        // You can change the line width
        shapeLayer.lineWidth = 3.0
            
        backView.layer.insertSublayer(shapeLayer, at: 0)
        return circlePath
    }
    
}
