//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 26/11/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let instance = LocationManager()
    
    private let manager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus? 
    @Published var location: CLLocationCoordinate2D? = nil
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyReduced
        manager.startUpdatingLocation()
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "Unknown"
        }
        
        switch status {
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        case .authorizedAlways:
            return "authorizedAlways"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        case .authorized:
            return "authorized"
        default:
            return "Unknown"
        }
    }
    
    private func checkLocationAuthorization() {
        guard let status = locationStatus else { return }
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
        checkLocationAuthorization()
        print(statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
