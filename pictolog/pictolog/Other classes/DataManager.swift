//
//  DataManager.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-20.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "pictolog")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createCountry(name: String) -> Country {
        let country = Country(context: persistentContainer.viewContext)
        country.name = name
        country.created_at = Date()
        country.updated_at = Date()
        return country
    }
    
    func createProvince(name: String, country: Country) -> Province {
        let province = Province(context: persistentContainer.viewContext)
        province.name = name
        province.created_at = Date()
        province.updated_at = Date()
        return province
    }
    
    func createCity(name: String, province: Province, country: Country) -> City {
        let city = City(context: persistentContainer.viewContext)
        city.name = name
        city.created_at = Date()
        city.updated_at = Date()
        return city
    }
    
    func createImage(imagesData: [Data]) -> Image {
        let image = Image(context: persistentContainer.viewContext)
        image.photo = imagesData
//        image.gallary_id =
        image.created_at = Date()
        image.updated_at = Date()
        return image
    }
    
    func createPlace(name: String, city: City, province: Province, country: Country, visitedOn: Date, latitude: Double, longitude: Double, note: String, images: Image) -> Place {
        let place = Place(context: persistentContainer.viewContext)
        place.name = name
        place.city = city
        place.province = province
        place.country = country
        place.visited_on = visitedOn
        place.latitude = latitude
        place.longitude = longitude
        place.note = note
        place.image = images
        place.created_at = Date()
        place.updated_at = Date()
        return place
    }
    
    func fetchPlace() -> [Place] {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        var places: [Place] = []
        
        do {
            places = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching places")
        }
        
        return places
    }
    
    
}
