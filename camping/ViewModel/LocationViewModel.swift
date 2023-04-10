//
//  HomeViewModel.swift
//  camping
//
//  Created by Thu Hoang on 5.4.2023.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    @Published var campingSites: [CampingSite] = []
    
    var array: [CampingSite] = []
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    // Request permission function
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Get authorization status from location manager
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    // Get last location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        fetchCity(for: lastSeenLocation)
        
    }
    
    // Fetch city based on current location
    func fetchCity(for location: CLLocation?) {
        guard let location = location else {return}
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.currentPlacemark = placemarks?.first
        }
    }
    
    // Fetch data from URL and store it to CoreData
    func fetchCampingSites() {
        let url = "https://users.metropolia.fi/~thuh/camping.json"
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let campingSites = try JSONDecoder().decode([CampingSiteData].self, from: data)
                
                DispatchQueue.main.async {
                    let context = PersistenceController.shared.container.viewContext
                    for campingSite in campingSites {
                        let campingSiteEntity = CampingSite(context: context)
                        
                        campingSiteEntity.name = campingSite.name
                        campingSiteEntity.location = campingSite.location as NSObject
                        campingSiteEntity.imageURL = campingSite.imageUrl
                        campingSiteEntity.descriptionEN = campingSite.description.EN
                        campingSiteEntity.descriptionFI = campingSite.description.FI
                        campingSiteEntity.suitabilityEN = campingSite.suitability.EN
                        campingSiteEntity.suitabilityFI = campingSite.suitability.FI
                        campingSiteEntity.category = campingSite.category
                        campingSiteEntity.region = campingSite.region
                        campingSiteEntity.hasTentSite = campingSite.hasTentSite
                        campingSiteEntity.hasCampfireSite = campingSite.hasCampfireSite
                        campingSiteEntity.hasRentalHut = campingSite.hasRentalHut
                        
                        do {
                            try context.save()
                            self.campingSites.append(campingSiteEntity)
                        } catch {
                            print("error")
                        }
                    }
                }
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        }.resume()
        
    }
    
}
