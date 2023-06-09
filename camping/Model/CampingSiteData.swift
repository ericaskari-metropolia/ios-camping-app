//
//  CampingSites.swift
//  camping
//
//  Created by The Minions on 7.4.2023.
//

import Foundation

struct CampingSiteData: Decodable {
    var placeId: String
    var name: String
    var imageUrl: String
    var description: Translation
    var suitability: Translation
    var category: String
    var region: String
    var city: String
    var websiteURL: String
    var address: String
    var hasTentSite: Bool
    var hasCampfireSite: Bool
    var hasRentalHut: Bool
    var latitude: Double
    var longitude: Double
    var isFavorite: Bool
}

struct Translation: Decodable {
    var EN: String
    var FI: String
}


