//
//  SearchViewModel.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//

import Foundation
import Speech
import SwiftUI

// This class is to handle Search logic

class SearchViewModel: ObservableObject {
    @Published var searchText: String
    @Published var filteredCities: [String] = []
    @Published var filteredCampingSites: [CampingSite] = []
    var fetchedCities: [String] = []
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    // Get city list from core data
    func filterFetchedCity(cities: FetchedResults<CampingSite>) {
        let cities = cities.compactMap { campingSite in
            campingSite.city
        }
        filteredCities = Array(Set(cities)).sorted()
        fetchedCities = Array(Set(cities)).sorted()
    }
    
    // Get search text in view and filter city based on search text
    func searchTextUpdated(value: String){
        if value.isEmpty {
            filteredCities = fetchedCities
            searchText = ""
        } else {
            filteredCities = fetchedCities.filter({ name in
                name.contains(value) == true
            })
            searchText = value
        }
    }
    
    // Filter camping sites that have the same city
    func filterCampingSiteCity(city: String, campingSites: FetchedResults<CampingSite>) {
        let campingSites = campingSites.compactMap{$0}
        filteredCampingSites = campingSites.filter { campingSite in
            campingSite.city == city
        }
        
    }
}
