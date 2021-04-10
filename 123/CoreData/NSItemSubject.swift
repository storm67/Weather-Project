//
//  NSItemSubject.swift
//  123
//
//  Created by Storm67 on 06/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

extension SimpleModel: NSItemProviderWriting, NSItemProviderReading {
    
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        let decoder = JSONDecoder()
        do {
            let subject = try decoder.decode(SimpleModel.self, from: data)
            return SimpleModel(name: subject.name, key: subject.key, lat: subject.lat, lon: subject.lon, position: subject.position, timeZone: subject.timeZone) as! Self
        } catch {
            fatalError(error as! String)
        }
    }
    
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData as String)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
    }
    
}
