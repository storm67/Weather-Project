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
class PagerViewModel: PageViewModelProtocol {

    var coreData: CoreDataProtocol
    var manager: PageManagerProtocol

    init(cdp: CoreDataProtocol, manager: PageManagerProtocol) {
        self.coreData = cdp
        self.manager = manager
    }

    func check() -> Bool {
        if manager.enabled() {
            return true
        }
        return false
    }

    func fetchData(completion:@escaping ([UIViewController]) -> Void) {
        coreData.fetchData { (md) in
            var controllers = [UIViewController]()
            let viewModel = Assembler.sharedAssembler.resolver.resolve(ViewModelProtocol.self)!
            for item in md {
                controllers.append(MainViewController(model: SimpleModel(name: item.name, key: item.key, lat: item.lat, lon: item.lon, position: item.position),viewModel: viewModel))
            }
            completion(controllers)
        }
    }
}

protocol PageViewModelProtocol {
    func fetchData(completion:@escaping ([UIViewController]) -> Void)
    func check() -> Bool
}
