//
//  Extensions.swift
//  123
//
//  Created by gdml on 06/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation

extension String {
    
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let finish = dateFormatterPrint.string(from: Date())
        return finish
    }
    
}
extension Int {
    
    func convertToCelsius() -> Int {
        return Int(5.0 / 9.0 * (Double(self) - 32.0))
    }
    
}


