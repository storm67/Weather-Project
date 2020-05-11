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
    
    func createData(name: String, key: Int?, lat: Double?, lon: Double?) -> Bool {
        
        let entity = NSEntityDescription.entity(forEntityName: "City", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        newUser.setValue(name, forKey: "name")
        newUser.setValue(key, forKey: "cityId")
        newUser.setValue(lat, forKey: "lat")
        newUser.setValue(lon, forKey: "lon")
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed saving")
        }
        return true
    }
    func fetchData(completion:@escaping ([SimpleModel]) -> Void) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            var item = [SimpleModel]()
            for data in result as! [NSManagedObject] {
                item.append(SimpleModel(name: data.value(forKey: "name") as! String, key: data.value(forKey: "cityId") as? Int, lat: data.value(forKey: "lat") as? Double, lon: data.value(forKey: "lon") as? Double))
            }
            completion(item)
            
        } catch {
            
            print("Failed")
        }
    }
}




