//
//  LocationManager.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import Foundation
import Combine
import CoreLocation

class LocationManager:  NSObject, ObservableObject {
    
    // Singleton instance
    public static let shared : LocationManager = {
        return LocationManager()
    }()
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    
        location = locationManager.location  ?? CLLocation(latitude: 0.0, longitude: 0.0)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        self.location = currentLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
            location = locationManager.location ?? CLLocation(latitude: 0.0, longitude: 0.0)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print(error.localizedDescription)
    }
}
