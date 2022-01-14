//
//
//  PageManagerViewModel.swift
//  123
//
//  Created by Andrey on 07/11/2020.
//  Copyright © 2020 gdml. All rights reserved.
//
import Foundation
import Swinject
import CoreLocation

class PagerViewModel: PageViewModelProtocol {

    var coreData: CoreDataProtocol
    var manager: PageManagerProtocol
    
    init(cdp: CoreDataProtocol, manager: PageManagerProtocol) {
        self.coreData = cdp
        self.manager = manager
    }

    func check() -> Bool {
        manager.enabled() ? true : false
    }

    func fetchData(completion:@escaping ([UIViewController]) -> Void) {
        coreData.fetchData { (md) in
            var controllers = [UIViewController]()
            guard let viewModel = Assembler.sharedAssembler.resolver.resolve(ViewModelProtocol.self) else { return }
            for item in md {
            controllers.append(MainViewController(model: SimpleModel(name: item.name, key: item.key, lat: item.lat, lon: item.lon, position: item.position, timeZone: item.timeZone)))
            }
            if self.extractor() {
            controllers.insert(MainViewController(model: SimpleModel(name: "Текущее местоположение", key: 0, lat: 0, lon: 0, position: 0, timeZone: 0)), at: 0)
            }
            completion(controllers)
        }
    }
    
    func extractor() -> Bool {
        var dto: SimpleModel?
        coreData.fetchData { (md) in
            dto = md.first ?? nil
        }
        guard let lat = dto?.lat else { return false }
        return lat == .zero ? true : false
    }
    
}

protocol PageViewModelProtocol {
    func fetchData(completion: @escaping ([UIViewController]) -> Void)
    func check() -> Bool
    func extractor() -> Bool
}
