//
//  Home.swift
//  camping
//
//  Created by The Minions on 3.4.2023.
//

import SwiftUI
import MapKit
import CoreData

// View for Home

struct HomeView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack(spacing: 5){
            HeaderHomePageView()
            ScrollView{
                VStack(alignment: .leading){
                    Text("homepage.category".i18n())
                        .bold()
                        .font(.system(size: 20))
                    CategoryListView()
                        .padding(.horizontal, 5)
                    Text("homepage.suggest".i18n())
                        .bold()
                        .font(.system(size: 20))
                    SuggestCampsitesView(userLocation: locationViewModel.lastSeenLocation ?? .init(latitude: 0, longitude: 0))
                        .padding(.horizontal, 5)
                }
                .padding(.horizontal, 10)
                
            }
        }
        .onAppear {
            locationViewModel.fetchCampingSites()
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(LocationViewModel())
    }
}
