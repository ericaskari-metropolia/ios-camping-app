//
//  CampingSites.swift
//  camping
//
//  Created by Thu Hoang on 7.4.2023.
//

import Foundation

struct CampingSiteData: Decodable {
    var name: String
    var location: [Double]
    var imageUrl: String
    var description: Translation
    var suitability: Translation
    var category: String
    var region: String
    var hasTentSite: Bool
    var hasCampfireSite: Bool
    var hasRentalHut: Bool
}

struct Translation: Decodable {
    var EN: String
    var FI: String
}
