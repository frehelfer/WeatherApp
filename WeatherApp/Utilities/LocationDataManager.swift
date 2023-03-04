//
//  LocationDataManager.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 22/02/23.
//

import Foundation
import CoreLocation

class LocationDataManager: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var location: Location? = nil
    @Published var isLoading: Bool = true
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
    }
    
    func requestLocation() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    func requestPermission() {
        isLoading = true
        locationManager.requestWhenInUseAuthorization()
    }
    
}

// MARK: - CLLocationManagerDelegate
extension LocationDataManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
            
        case .authorizedAlways:
            manager.requestLocation()
            break
            
        case .authorizedWhenInUse:
            manager.requestLocation()
            break
            
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
            break
            
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
            break
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
            
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first?.coordinate else { return }
        location = Location(lat: newLocation.latitude, lon: newLocation.longitude)
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("🚨 error: \(error.localizedDescription)")
        isLoading = false
    }
}
