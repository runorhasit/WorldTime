//
//  LocationManager.swift
//  WorldTime
//
//  Created by Runor Jiroma on 06/01/2026.
//

import Foundation
import CoreLocation
import Combine
import MapKit

final class LocationManager: NSObject, ObservableObject {
    
    @Published var userCity: CityTime?
    @Published var permissionDenied: Bool = false
    
    private let locationManager = CLLocationManager()
    private let cityDatabase = CityDatabase()
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            permissionDenied = true
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first else { return }
            
            let cityName = placemark.locality ?? placemark.subAdministrativeArea ?? "Unknown"
            let timeZoneId = placemark.timeZone?.identifier ?? TimeZone.current.identifier
            
            DispatchQueue.main.async {
                self?.userCity = CityTime(city: cityName, timeZoneIdentifier: timeZoneId)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
