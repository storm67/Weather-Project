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
    func createData(name: String, key: Double?, lat: Double?, lon: Double?, timeZoneOffset: Int) -> Bool {
        let object = City(context: context)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let count = try? self.context.count(for: fetchRequest)
        object.setValue(name, forKey: "name")
        object.setValue(key, forKey: "cityId")
        object.setValue(lat, forKey: "lat")
        object.setValue(lon, forKey: "lon")
        object.setValue(count, forKey: "position")
        object.setValue(timeZoneOffset, forKey: "timeZoneOffset")
        //let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        background.perform {
            do {
                self.city.append(object)
                try self.context.save()
                //try self.context.execute(deleteRequest)
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
            print(result)
            for data in city {
                guard let name = data.name else { return }
                item.append(SimpleModel(name: name, key: Int(data.cityId), lat: data.lat, lon: data.lon, position: Int(data.position), timeZone: Int(data.timeZoneOffset))
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
            completion()
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion()
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        self.context.delete(self.city[indexPath.row])
        context.mergePolicy = NSMergePolicy.overwrite
        context.refreshAllObjects()
        do {
            try context.save()
            print("Data Deleted")
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
        }
    }
    
    func move(_ index: Int, _ dest: Int) {
            let item = city[index]
            city.remove(at: index)
            city.insert(item, at: dest)
            for (index, name) in city.enumerated() {
                name.position = Double(index)
            }
            do {
                try self.context.save()
            } catch {
                print("Failed to move data: ", error.localizedDescription)
            }
        }
    
    func checker() -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [City]
            city = result
            print(city)
        } catch {
            print("Failed")
        }
        return city.isEmpty ? true : false
    }
}

protocol CoreDataProtocol {
    func move(_ index: Int, _ dest: Int)
    func checker() -> Bool
    func deleteData(indexPath: IndexPath)
    func resetable(completion:@escaping () -> Void)
    func fetchData(completion:@escaping ([SimpleModel]) -> Void)
    func createData(name: String, key: Double?, lat: Double?, lon: Double?, timeZoneOffset: Int) -> Bool
    var city: [City] { get set }
}

