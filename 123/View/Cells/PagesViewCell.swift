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
    var viewModel: City! {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.name
        }
    }
}
