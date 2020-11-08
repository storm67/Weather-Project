//
//  CitiesData.swift
//  123
//
//  Created by gdml on 13/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

final class PageManagerViewModel: PageManagerProtocol {
    
    var manager: CoreDataProtocol
    var index = 0
    var pages = [City]()
    
    func cellViewModel(index: Int) -> City? {
        guard index < pages.count else { return nil }
        return manager.city[index]
    }
    
    func model() -> [City] {
        return manager.city
    }
    
    func enabled() -> Bool {
    if index >= 1 {
        index -= 1
        return true
    }
        return false
    }
    
    func count() -> Int {
        return manager.city.count
    }
    
    func rearrange(complete: @escaping () -> ()) {
        manager.resetable {
            complete()
        }
    }
    
    func cellViewerModel(_ int: Int) -> City? {
        manager.cellViewModel(index: int)
    }
    
    func refresh(_ sourceIndexPath: IndexPath,_ item: City,_ destinationIndexPath: IndexPath) {
        let item = manager.city[sourceIndexPath.row]
        manager.city.remove(at: sourceIndexPath.row)
        manager.city.insert(item, at: destinationIndexPath.row)
        for (index, name) in manager.city.enumerated() {
            name.position = Double(index)
        }
        index += 1
    }
    
    func delete(_ indexPath: IndexPath) {
        manager.deleteData(indexPath: indexPath)
        manager.city.remove(at: indexPath.row)
        index += 1
    }
    init(manager: CoreDataProtocol) {
        self.manager = manager
    }
    
}

protocol PageManagerProtocol {
    func enabled() -> Bool
    func delete(_ indexPath: IndexPath)
    func refresh(_ sourceIndexPath: IndexPath,_ item: City,_ destinationIndexPath: IndexPath)
    func rearrange(complete: @escaping () -> ())
    func cellViewModel(index: Int) -> City?
    var pages: [City] { get set }
    func count() -> Int
    func model() -> [City]
    func cellViewerModel(_ int: Int) -> City?
}
