//
//  backgroundView.swift
//  123
//
//  Created by gdml on 01/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

final class BackgroundView: NSObject {
    
    
    func switchImage<T>(_ imageView: T, _ image: String) -> UIImage where T: UIView {
        switch image.description {
        case let str where str.contains("ив") || str.contains("ожд"):
            return UIImage(named: "12Black")!
        case let str where str.contains("Солн"):
            return UIImage(named: "1Black")!
        case let str where str.contains("Преимущественно облачно"):
            return UIImage(named: "6Black")!
        case let str where str.contains("Переменная облачность") || str.contains("Небольшая облачность"):
            return UIImage(named: "4Black")!
        case let str where str.contains("Снег"):
            return UIImage(named: "15Black")!
        case let str where str.contains("Небольшой снег"):
            return UIImage(named: "20Black")!
        case let str where str.contains("Холодно"):
            return UIImage(named: "snowflake")!
        case let str where str.contains("Небольшая облачность, небольшой снег"):
            return UIImage(named: "20Black")!
        case let str where str.contains("Преимущественно ясно"):
            return UIImage(named: "1Black")!
        case let str where str.contains("Облачно"):
            return UIImage(named: "4Black")!
        case let str where str.contains("Грозы"):
            return UIImage(named: "23Black")!
        default:
            return UIImage()
        }
    }
    
    func random() -> UIImage {
        let random = Int.random(in: 1...14)
        switch random {
        case 1: return UIImage(named: "Altern")!
        case 2: return UIImage(named: "DayMountain")!
        case 3: return UIImage(named: "DesertMountain")!
        case 4: return UIImage(named: "Evening")!
        case 5: return UIImage(named: "EveningLast")!
        case 6: return UIImage(named: "MountainEvening")!
        case 7: return UIImage(named: "MountainsSmoke")!
        case 8: return UIImage(named: "Night1")!
        case 9: return UIImage(named: "NightMountain")!
        case 10: return UIImage(named: "NightMountain")!
        case 11: return UIImage(named: "EveningLast")!
        case 12: return UIImage(named: "PreDay")!
        case 13: return UIImage(named: "riverForest")!
        case 14: return UIImage(named: "UFO")!
        default:
        return UIImage()
        }
    }
    
}
protocol BackViewProtocol {
    func switchImage(_ image: String) -> UIImage
}
