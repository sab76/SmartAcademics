//
//   LocationManager.swift
//  Smart Academics, Wellness, and Rest Planner
//To incorporate location data, use the CoreLocation framework. Ensure you request the appropriate permissions from the user in your Info.plist and at runtime

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() 
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Example use of location
        print("Updated location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // Other operations using location...
    }

}

