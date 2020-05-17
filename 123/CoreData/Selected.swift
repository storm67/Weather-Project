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

class Selected {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var city: [City] = []
    func createData(name: String, key: Double?, lat: Double?, lon: Double?) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "City", in: context)
        let object = City(context: context)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        object.setValue(name, forKey: "name")
        object.setValue(key, forKey: "cityId")
        object.setValue(lat, forKey: "lat")
        object.setValue(lon, forKey: "lon")
        do {
            ///try context.execute(deleteRequest)
            let set = try context.fetch(fetchRequest)
            city.append(object)
            print(city)
            let count = try context.count(for: fetchRequest)
            object.setValue(count, forKey: "position")
            try context.save()
            for i in 0..<set.count {
             print(i)
            }
        } catch {
            print("Failed saving")
        }
        return true
    }
    func fetchData(completion:@escaping ([SimpleModel]) -> Void) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let result = try? context.fetch(request) as! [City]

        do {
            city = result!
            var item = [SimpleModel]()
            for data in city {
                item.append(SimpleModel(name: data.name!, key: Int(data.cityId), lat: data.lat, lon: data.lon, position: Int(data.position)))
            }
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

