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
import SideMenu

class Injector: Assembly {
    func assemble(container: Container) {
        container.register(LocationManagerProtocol.self) { r in
            LocationManager()
        }.inObjectScope(.container)
        container.register(CoreDataProtocol.self) { r in
            CoreDataManager()
        }.inObjectScope(.container)
        container.register(ViewModelProtocol.self) { r in
            let coreDataManager = r.resolve(CoreDataProtocol.self)!
            return MainControllerViewModel(networkService: Routing<WeatherAPI>(), coreDataManager: coreDataManager)
        }.inObjectScope(.container)
         .initCompleted { (r, v) in
            let vm = v as! MainControllerViewModel
            vm.pageViewModel = r.resolve(PageManagerProtocol.self)!
        }
        container.register(UIViewControllerTransitioningDelegate.self) { (r) in
            TransitionController()
        }
        container.register(PageManagerProtocol.self) { r in
            let coreDataManager = r.resolve(CoreDataProtocol.self)!
            return PageManagerViewModel(manager: coreDataManager)
        }.inObjectScope(.container)
        container.register(PageViewModelProtocol.self) { r in
            let coreDataManager = r.resolve(CoreDataProtocol.self)!
            let pageManager = r.resolve(PageManagerProtocol.self)!
            return PagerViewModel(cdp: coreDataManager, manager: pageManager)
        }.inObjectScope(.container)
        container.register(CitySelectorProtocol.self) { r in
            CitySelectorViewModel(manager: Routing<WeatherAPI>())
        }.inObjectScope(.container)
        container.register(LocationInterfaceProtocol.self) { (r) in
            let location = r.resolve(LocationManagerProtocol.self)!
            let coreDataManager = r.resolve(CoreDataProtocol.self)!
            return LocationInterface(locationManager: location, coreDataManager: coreDataManager)
        }.inObjectScope(.container)
        container.storyboardInitCompleted(UINavigationController.self) { _, _ in }
        container.storyboardInitCompleted(SideMenuNavigationController.self) { _, _ in }
        container.storyboardInitCompleted(CitySelector.self) { r,c in
            c.viewModel = r.resolve(CitySelectorProtocol.self)!
        }
//        container.storyboardInitCompleted(MainViewController.self) { r,c in
//            c.viewModel = r.resolve(ViewModelProtocol.self)!
//        }
        container.storyboardInitCompleted(PageViewController.self) { r,c in
            c.viewModel = r.resolve(PageViewModelProtocol.self)!
        }
        container.storyboardInitCompleted(PagesViewController.self) { r,c in
            c.viewModel = r.resolve(PageManagerProtocol.self)!
        }
        container.storyboardInitCompleted(ClearNavigationController.self) { r,c in
            c.viewModel = r.resolve(LocationInterfaceProtocol.self)!
        }
        SwinjectStoryboard.defaultContainer = container
}
}
