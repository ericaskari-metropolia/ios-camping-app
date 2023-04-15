//
//  Home.swift
//  camping
//
//  Created by Chi Nguyen on 3.4.2023.
//

import SwiftUI
import MapKit
import CoreData

struct HomeView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    
    var body: some View {
        VStack(spacing: spacing){
            HeaderHomePageView()
            
            CategoryListView().padding(.horizontal, 5)
            
            ScrollView{
                
                HStack{
                    Text("Latitude:")
                    Text("\(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0)")
                }
                
                HStack{
                    Text("Longitude:")
                    Text("\(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)")
                }
                
                HStack{
                    Text("City:")
                    Text(locationViewModel.currentPlacemark?.locality ?? "")
                }
                
                HStack{
                    Text("campsite:")
                    Text("\(results.count)")
                }
                
                ForEach(results, id: \.self) { campingSite in
                    HStack{
                        Text("Camping site:")
                        Text(campingSite.websiteURL ?? "")
                    }
                }
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
