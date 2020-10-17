//
//  Selected.swift
//  123
//
//  Created by gdml on 09/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Swinject

class CoreDataManager: CoreDataProtocol {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let background = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    var city: [City] = []
    
    @discardableResult
    func createData(name: String, key: Double?, lat: Double?, lon: Double?) -> Bool {
        let object = City(context: context)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let count = try? self.context.count(for: fetchRequest)
        object.setValue(name, forKey: "name")
        object.setValue(key, forKey: "cityId")
        object.setValue(lat, forKey: "lat")
        object.setValue(lon, forKey: "lon")
        object.setValue(count, forKey: "position")
        background.perform {
            do {
                self.city.append(object)
                try self.context.save()
            }
            catch {
                print("Failed saving")
            }
        }
        return true
    }
    func fetchData(completion:@escaping ([SimpleModel]) -> Void) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let result = try context.fetch(request) as! [City]
            city = result
            var item = [SimpleModel]()
            for data in city {
                guard let name = data.name else { return }
                item.append(SimpleModel(name: name, key: Int(data.cityId), lat: data.lat, lon: data.lon, position: Int(data.position))
                )}
            completion(item)
        } catch {
            print("Failed")
        }
    }
    func resetable(completion:@escaping () -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            city = try context.fetch(request) as! [City]
            print("Data fetched, no issues")
            completion()
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion()
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        context.delete(city[indexPath.row])
        do {
            try context.save()
            print("Data Deleted")
            
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
            
        }
    }
    
    func cellViewModel(index: Int) -> City? {
        guard index < city.count else { return nil }
        return city[index]
    }
}

protocol CoreDataProtocol {
    func cellViewModel(index: Int) -> City?
    func deleteData(indexPath: IndexPath)
    func resetable(completion:@escaping () -> Void)
    func fetchData(completion:@escaping ([SimpleModel]) -> Void)
    func createData(name: String, key: Double?, lat: Double?, lon: Double?) -> Bool
    var city: [City] { get set }
}

class PagerViewModel: PageViewModelProtocol {
    var coreData: CoreDataProtocol
    
    init(cdp: CoreDataProtocol) {
        self.coreData = cdp
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
}
