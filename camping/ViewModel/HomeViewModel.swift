//
//  HomeViewModel.swift
//  camping
//
//  Created by Thu Hoang on 5.4.2023.
//

import Foundation
import SwiftUI

// This class is to handle logic to filter camping sites based on user's location

class HomeViewModel: ObservableObject {
    @Published var suggestCampsites: [CampingSite] = []
    
    // Calculate distance between camping site coordinates and user's coordinates
    func calculateDistanceBetweenTwoCoordinates(campSiteLatitude: Double, campSitelogitude: Double) -> Double {
        
        // Get user's location. If there is none, set to Helsinki coordinates
        let userLatitude = LocationViewModel().lastSeenLocation?.coordinate.latitude ?? 60.192059
        //        60.192059
        //        67.92223
        let userLongitude = LocationViewModel().lastSeenLocation?.coordinate.longitude ?? 24.945831
        //        24.945831
        //        26.504644
        
        // Convert coordinate to radians
        let campSiteLongitudeRadian = campSitelogitude * Double.pi / 180
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
    func suggestCampsiteBasedOnDistance(campingSites: FetchedResults<CampingSite>) {
        let campingSites = campingSites.compactMap{$0}
        suggestCampsites = campingSites.filter { campingSite in
            calculateDistanceBetweenTwoCoordinates(campSiteLatitude: campingSite.latitude, campSitelogitude: campingSite.longitude) <= 100
        }
    }
}

