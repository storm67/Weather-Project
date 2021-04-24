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
    var pages = [PageCellModel?]()
    
    func model() -> [PageCellModel?] {
        guard !pages.isEmpty else { return [] }
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
    
    func extractor() -> Bool {
        var dto: SimpleModel?
        manager.fetchData { (md) in
            dto = md.first ?? nil
        }
        return Int(dto?.lat ?? 0) >= 0 ? true : false
    }
    
    func cellViewModel(_ index: Int) -> PageCellModel? {
        guard index < pages.count else { return nil }
        return pages[index]
    }
    
    func refresh(_ sourceIndexPath: IndexPath,_ destinationIndexPath: IndexPath) {
        let item = pages[sourceIndexPath.row]
        pages.remove(at: sourceIndexPath.row)
        pages.insert(item, at: destinationIndexPath.row)
        manager.move(sourceIndexPath.row, destinationIndexPath.row)
        index += 1
    }
    
    func delete(_ indexPath: IndexPath) {
        pages.remove(at: indexPath.row)
        manager.deleteData(indexPath: indexPath)
        index += 1
    }
    
    func correctTime(offset: Int) -> String {
        Int.nowState(timeOffset: offset)
    }
    
    @objc func loader(notification: Notification, completion: @escaping () -> Void) {
        guard let notify = notification.userInfo as? [String : Convertible], let phrase = notify["path"]?.dayIconPhrase, let temp = notify["path"]?.temperature else { return }
            manager.fetchData { [weak self] (smp) in
            for core in smp {
                guard self?.index == 0, self?.pages.count != smp.count else { break }
                self?.pages.append(PageCellModel(name: core.name, date: core.timeZone, phrase: nil, temp: nil))
            }
            guard let item = self?.pages[self?.index ?? 0] else { return }
            if item.phrase == nil && item.temp == nil {
                item.phrase = phrase
                item.temp = temp
                self?.index += 1
                }
            if self?.index == self?.pages.count { self?.index == 0 }
                completion()
    }
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
    var pages: [PageCellModel?] { get set }
    func count() -> Int
    func model() -> [PageCellModel?]
    func cellViewModel(_ index: Int) -> PageCellModel?
    func correctTime(offset: Int) -> String
    func loader(notification: Notification, completion: @escaping () -> Void)
    func extractor() -> Bool
}

