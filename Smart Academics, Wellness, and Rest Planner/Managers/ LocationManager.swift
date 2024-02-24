//
//   LocationManager.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//To incorporate location data, use the CoreLocation framework. Ensure you request the appropriate permissions from the user in your Info.plist and at runtime

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // or requestAlwaysAuthorization() based on your need
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

