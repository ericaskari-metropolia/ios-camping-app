//
//  HomeViewModel.swift
//  camping
//
//  Created by The Minions on 5.4.2023.
//

import CoreData
import CoreLocation
import Foundation
import MapKit

// This class is for handling asking everything about getting user's location
// and fetching and saving data to core data from JSON

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    @Published var campingSites: [CampingSite] = []
    
    @Published var region: MKCoordinateRegion = .init(
        center: CLLocationCoordinate2D(latitude: 60.192059, longitude: 24.945831),
        span: MKCoordinateSpan(latitudeDelta: zoomSpan, longitudeDelta: zoomSpan)
    )
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
    
    // Request permission to get user's location function
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
        guard let latestLocation = lastSeenLocation else {
            return
        }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: zoomSpan, longitudeDelta: zoomSpan)
            )
        }
    }
    
    // Fetch city based on current location
    func fetchCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            self.currentPlacemark = placemarks?.first
        }
    }
    
    // Fetch data from URL and store it to CoreData
    func fetchCampingSites() {
        let url = "https://users.metropolia.fi/~thuh/camping-5.json"
        guard let url = URL(string: url) else { return }
        
        // Fetch from URL
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                // Decode JSON
                let campingSites = try JSONDecoder().decode([CampingSiteData].self, from: data)
                
                DispatchQueue.main.async {
                    let context = PersistenceController.shared.container.viewContext
                    
                    let request: NSFetchRequest<CampingSite> = CampingSite.fetchRequest()
                    
                    // Checking if the data is in core data or not.
                    // If data from JSON is updated then updated to core data.
                    // If the data is the same, skip saving to avoid duplicate.
                    // If there is no data in core data, save it.
                    do {
                        let fetchedCampingSitesCD = try context.fetch(request)
                        
                        for campingSite in campingSites {
                            if !fetchedCampingSitesCD.isEmpty {
                                for fetchedCampingSiteCD in fetchedCampingSitesCD {
                                    if fetchedCampingSiteCD.placeId == campingSite.placeId {
                                        continue
                                    }
                                }
                            } else {
                                let newCampingSiteEntity = NSEntityDescription.insertNewObject(forEntityName: "CampingSite", into: context) as! CampingSite
                                
                                // Saving to core data
                                newCampingSiteEntity.placeId = campingSite.placeId
                                newCampingSiteEntity.name = campingSite.name
                                newCampingSiteEntity.imageURL = campingSite.imageUrl
                                newCampingSiteEntity.descriptionEN = campingSite.description.EN
                                newCampingSiteEntity.descriptionFI = campingSite.description.FI
                                newCampingSiteEntity.suitabilityEN = campingSite.suitability.EN
                                newCampingSiteEntity.suitabilityFI = campingSite.suitability.FI
                                newCampingSiteEntity.category = campingSite.category
                                newCampingSiteEntity.region = campingSite.region
                                newCampingSiteEntity.city = campingSite.city
                                newCampingSiteEntity.websiteURL = campingSite.websiteURL
                                newCampingSiteEntity.address = campingSite.address
                                newCampingSiteEntity.hasTentSite = campingSite.hasTentSite
                                newCampingSiteEntity.hasCampfireSite = campingSite.hasCampfireSite
                                newCampingSiteEntity.hasRentalHut = campingSite.hasRentalHut
                                newCampingSiteEntity.latitude = campingSite.latitude
                                newCampingSiteEntity.longitude = campingSite.longitude
                                newCampingSiteEntity.isFavorite = campingSite.isFavorite
                            }
                        }
                    } catch {
                        print("FAIL fetch camping site")
                    }
                    do {
                        try context.save()
                    } catch {
                        print("error")
                    }
                }
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        }.resume()
    }
}
