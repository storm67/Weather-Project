//
//  backgroundView.swift
//  123
//
//  Created by gdml on 01/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView: NSObject {
    
    func switchImage(_ image: Int) -> UIImage {
        switch image {
        case 1...2: return UIImage(named: "autumn")!
        case 3...4: return UIImage(named: "cloudy-1")!
        case 5...6: return UIImage(named: "cloudy")!
        case 7...8: return UIImage(named: "foggy")!
        case 9...10: return UIImage(named: "full-moon")!
        case 11...12: return UIImage(named: "mountain")!
        case 13...14: return UIImage(named: "night")!
        case 15...16: return UIImage(named: "rain-1")!
        case 17...18: return UIImage(named: "rain")!
        case 19...20: return UIImage(named: "rainbow")!
        case 21...22: return UIImage(named: "snow")!
        case 23...26: return UIImage(named: "snowing")!
        case 27...29: return UIImage(named: "spring")!
        case 30...32: return UIImage(named: "summer")!
        case 33...35: return UIImage(named: "sun")!
        case 36...38: return UIImage(named: "temperature")!
        case 39...41: return UIImage(named: "thunder")!
        case 42...44: return UIImage(named: "umbrella")!

        default:
            break
        }
        return UIImage()
    }
}
