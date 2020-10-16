//
//  Injector.swift
//  123
//
//  Created by Andrey on 03/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class Injector: Assembly {
    func assemble(container: Container) {
        container.register(NetworkingProtocol.self) { _ in
            NetworkService()
        }.inObjectScope(.container)
        container.register(LocationManagerProtocol.self) { r in
            LocationManager()
        }.inObjectScope(.container)
        container.register(CoreDataProtocol.self) { r in
            CoreDataManager()
        }.inObjectScope(.container)
        container.register(PageManagerProtocol.self) { r in
            PageManagerViewModel(manager: r.resolve(CoreDataProtocol.self)!)
        }.inObjectScope(.container)
        container.register(ViewModelProtocol.self) { r in
            MainControllerViewModel(data: r.resolve(NetworkingProtocol.self)!)
        }.inObjectScope(.container)
        container.register(PageViewModelProtocol.self) { r in
            PagerViewModel(p: r.resolve(CoreDataProtocol.self)!)
        }.inObjectScope(.container)
        container.register(CitySelectorProtocol.self) { r in
            CitySelectorViewModel(manager: r.resolve(NetworkingProtocol.self)!, location: r.resolve(LocationManagerProtocol.self)!, coreData: r.resolve(CoreDataProtocol.self)!)
        }.inObjectScope(.container)
        container.storyboardInitCompleted(UINavigationController.self) { _, _ in }
        container.storyboardInitCompleted(CitySelector.self) { r,c in
            c.viewModel = r.resolve(CitySelectorProtocol.self)!
        }
        container.storyboardInitCompleted(MainViewController.self) { r,c in
            c.viewModel = r.resolve(ViewModelProtocol.self)!
        }
        container.storyboardInitCompleted(PageViewController.self) { r,c in
            c.manager = r.resolve(PageViewModelProtocol.self)!
        }
        container.storyboardInitCompleted(PagesViewController.self) { r,c in
            c.viewModel = r.resolve(PageManagerProtocol.self)!
        }
        SwinjectStoryboard.defaultContainer = container
    }
}
//
extension SwinjectStoryboard {
    class func setup() {
      let assembler = Assembler(container: defaultContainer)
      assembler.apply(assemblies: [Injector()])
    }
}
extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()

        let assembler = Assembler(
            [
                Injector()
            ],
            container: container)

        return assembler
    }()
}
