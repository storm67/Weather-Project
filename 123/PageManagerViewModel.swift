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
    var pages = [SimpleModel]()
    

    func model() -> [SimpleModel] {
        return pages
    }

    func enabled() -> Bool {
    if index >= 1 {
        index -= 1
        return true
    }
        return false
    }

    func count() -> Int {
        return pages.count
    }

    func rearrange(complete: @escaping () -> ()) {
        manager.resetable {
            complete()
        }
    }
    
    func add() {
        manager.fetchData { item in
            self.pages = item
        }
    }
    

    func cellViewModel(_ index: Int) -> SimpleModel? {
        guard index < pages.count else { return nil }
        return pages[index]
    }

    func refresh(_ sourceIndexPath: IndexPath,_ destinationIndexPath: IndexPath) {
        manager.move(sourceIndexPath.row, destinationIndexPath.row)
        add()
        index += 1
    }

    func delete(_ indexPath: IndexPath) {
        pages.remove(at: indexPath.row)
        manager.deleteData(indexPath: indexPath)
        index += 1
    }

    
    init(manager: CoreDataProtocol) {
        self.manager = manager
    }

}

protocol PageManagerProtocol {
    func enabled() -> Bool
    func delete(_ indexPath: IndexPath)
    func refresh(_ sourceIndexPath: IndexPath,_ destinationIndexPath: IndexPath)
    func rearrange(complete: @escaping () -> ())
    var pages: [SimpleModel] { get set }
    func count() -> Int
    func model() -> [SimpleModel]
    func cellViewModel(_ index: Int) -> SimpleModel?
    func add()
}
