//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 28/02/23.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    @Published var locationsEntities: [LocationEntity] = []
    
    let container: NSPersistentContainer
    
    static let shared = CoreDataManager()
    private init() {
        self.container = NSPersistentContainer(name: "Locations")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error loading core data: \(error.localizedDescription)")
            }
        }
        
        fetchLocations()
    }
    
    func fetchLocations() {
        let request = NSFetchRequest<LocationEntity>(entityName: "LocationEntity")
        
        do {
            locationsEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching Core Data Entity: \(error.localizedDescription)")
        }
    }
    
    func addLocation(location: Location) {
        let newLocation = LocationEntity(context: container.viewContext)
        newLocation.cityName = location.cityName
        newLocation.lat = location.lat
        newLocation.lon = location.lon
        
        saveData()
    }
    
    func removeLocation(location: Location) {
        guard let index = locationsEntities.firstIndex(where: { $0.lat == location.lat && $0.lon == location.lon }) else { return }
        let entity = locationsEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchLocations()
        } catch {
            print("Error saving Core Data: \(error.localizedDescription)")
        }
    }
}
