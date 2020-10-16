//
//  backgroundView.swift
//  123
//
//  Created by gdml on 01/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

final class BackgroundView: NSObject, BackViewProtocol {
    
    func switchImage(_ image: Int) -> UIImage {
        switch image {
        case 1...2: return UIImage(named: "021-night")!
        case 3...4: return UIImage(named: "021-rain-1")!
        case 5...6: return UIImage(named: "021-rain-2")!
        case 7...8: return UIImage(named: "021-rain")!
        case 9...10: return UIImage(named: "021-snowflake")!
        case 11...12: return UIImage(named: "021-snowing-1")!
        case 13...14: return UIImage(named: "021-snowing-2")!
        case 15...16: return UIImage(named: "021-snowing-3")!
        case 17...18: return UIImage(named: "021-snowing")!
        case 19...20: return UIImage(named: "021-storm")!
        case 21...22: return UIImage(named: "021-sun")!
        case 23...26: return UIImage(named: "021-sunrise")!
        case 27...29: return UIImage(named: "021-sunset")!
        case 30...32: return UIImage(named: "021-tornado")!
        case 33...35: return UIImage(named: "021-winter")!
        case 36...38: return UIImage(named: "021-sun")!
        case 39...41: return UIImage(named: "021-sunset")!
        case 42...44: return UIImage(named: "021-night")!

        default:
            break
        }
        return UIImage()
    }
}

protocol BackViewProtocol {
    func switchImage(_ image: Int) -> UIImage
}
