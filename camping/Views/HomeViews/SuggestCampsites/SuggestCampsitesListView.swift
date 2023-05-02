//
//  SuggestCampsites.swift
//  camping
//
//  Created by The Minions on 19.4.2023.
//

import SwiftUI
import MapKit

// View for suggest camping sites based on user's location

struct SuggestCampsitesView: View {
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    @StateObject var homeViewModel = HomeViewModel(suggestCampsites: [], lastUserLocation: .init(latitude: 0, longitude: 0))
    let userLocation: CLLocation
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center, spacing: 20){
                ForEach(homeViewModel.suggestCampsites, id: \.self){campingSite in
                    NavigationLink(destination: CampsiteDetailView(campsite: campingSite)){
                        SuggestCampsitesListItemView(campingSite: campingSite)
                    }
                }
            }
            .frame(height: 170)
            .padding(.vertical, 10)
        }
        // Change suggest camping sites list if user changed location
        .onChange(of: userLocation, perform: { newValue in
            homeViewModel.suggestCampsiteBasedOnDistance(campingSites: results, userLatitude: newValue.coordinate.latitude, userLongitude: newValue.coordinate.longitude)
        })
        .onAppear{
            homeViewModel.suggestCampsiteBasedOnDistance(campingSites: results, userLatitude: userLocation.coordinate.latitude, userLongitude: userLocation.coordinate.longitude)
        }
    }
}
