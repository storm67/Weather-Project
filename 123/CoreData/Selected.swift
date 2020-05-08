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

class Selected: NSObject {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var city = [City]()
    
    func createData(name: String?, key: Int?, _ lat: Double?, _ lon: Double?) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let newUser = NSEntityDescription.entity(forEntityName: "City", in: context)!
        let user = NSManagedObject(entity: newUser, insertInto: context)

        user.setValue(key, forKey: "cityId")
        user.setValue(lat, forKey: "lat")
        user.setValue(lon, forKey: "lon")
        do {
            try context.save()
            print("saved")
        }
        catch {
            print(error)
        }
        
        
    }
   
    func fetchData(completion:@escaping (City?) -> Void) {
         do {
            try self.city = self.context.fetch(City.fetchRequest())
            for result in self.city {
                let cityEntity = City(context: self.context)
                    cityEntity.cityId = Int64(result.cityId)
                    cityEntity.name = result.name
                    cityEntity.lat = result.lat
                    cityEntity.lon = result.lon
                    completion(cityEntity)
            }
        } catch {
            print(error)
            completion(nil)
        }
}
}
    
    
    


