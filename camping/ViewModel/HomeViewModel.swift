//
//  HomeViewModel.swift
//  camping
//
//  Created by The Minions on 5.4.2023.
//

import Foundation
import SwiftUI
import MapKit

// This class is to handle logic to filter camping sites based on user's location

class HomeViewModel: ObservableObject {
    @Published var suggestCampsites: [CampingSite] = []
    private var lastUserLocation: CLLocation
    
    init(suggestCampsites: [CampingSite], lastUserLocation: CLLocation) {
        self.suggestCampsites = suggestCampsites
        self.lastUserLocation = lastUserLocation
    }
    
    // Calculate distance between camping site coordinates and user's coordinates
    func calculateDistanceBetweenTwoCoordinates(campSiteLatitude: Double, campSiteLongitude: Double, userLatitude: CLLocationDegrees, userLongitude:  CLLocationDegrees ) -> Double {
        
        // Convert coordinate to radians
        let campSiteLongitudeRadian = campSiteLongitude * Double.pi / 180
        let userLongitudeRadian = userLongitude * Double.pi / 180
        let campSiteLatitudeRadian = campSiteLatitude * Double.pi / 180
        let userLatitudeRadian = userLatitude * Double.pi / 180
        
        
        // Haversine formula
        let distanceLogitude = userLongitudeRadian - campSiteLongitudeRadian
        let distanceLatitude = userLatitudeRadian - campSiteLatitudeRadian
        let a = pow(sin(distanceLatitude/2), 2)
        + cos(campSiteLatitudeRadian) * cos(userLatitudeRadian)
        * pow(sin(distanceLogitude/2), 2)
        let c = 2 * asin(sqrt(a))
        
        // Radius of earth in kilometers.
        let r = 6371
        
        return (c*Double(r))
    }
    
    // Filter camping sites based on distance
    func suggestCampsiteBasedOnDistance(campingSites: FetchedResults<CampingSite>, userLatitude: CLLocationDegrees, userLongitude:  CLLocationDegrees) {
        let distanceInMeter = self.lastUserLocation.distance(from: CLLocation(latitude: userLatitude, longitude: userLongitude))
        
        // Checking if the user moved more than 50km from original location, then update new list, other wise return
        if self.lastUserLocation == CLLocation(latitude: userLatitude, longitude: userLongitude) || distanceInMeter <= 50000 {
            return
        } else {
            lastUserLocation = .init(latitude: userLatitude, longitude: userLongitude)
            suggestCampsites = campingSites.filter { campingSite in
                calculateDistanceBetweenTwoCoordinates(campSiteLatitude: campingSite.latitude, campSiteLongitude: campingSite.longitude, userLatitude: userLatitude, userLongitude: userLongitude) <= 150
            }
        }
        
        // If suggestCampsites is empty, random in core data and take the first 5 campsites
        if suggestCampsites.isEmpty {
            suggestCampsites = Array(campingSites.shuffled().prefix(5))
        }
        
    }
}

