//
//  CellView.swift
//  123
//
//  Created by gdml on 13/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

final class CellView: UITableViewCell {
    var viewModel: CellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.name
            detailTextLabel?.text = viewModel.country
        }
}
}

