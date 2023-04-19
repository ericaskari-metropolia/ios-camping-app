//
//  Home.swift
//  camping
//
//  Created by Chi Nguyen on 3.4.2023.
//

import SwiftUI
import MapKit
import CoreData

// View for Home

struct HomeView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    @FetchRequest(entity: Plan.entity(), sortDescriptors:[]) var planResults: FetchedResults<Plan>
    
    var body: some View {
        VStack(spacing: 5){
            HeaderHomePageView()
            ScrollView{
                VStack(alignment: .leading){
                    Text("Category")
                        .bold()
                        .font(.system(size: 20))
                    CategoryListView()
                        .padding(.horizontal, 5)
                    Text("Suggested for you")
                        .bold()
                        .font(.system(size: 20))
                    SuggestCampsitesView()
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
