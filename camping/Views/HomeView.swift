////
////  Home.swift
////  camping
////
////  Created by Chi Nguyen on 3.4.2023.
////
//
//import SwiftUI
//import MapKit
//
//struct HomeView: View {
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10){
//            CampCategoryView()
//        }
//        .padding()
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            CampCategoryView()
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
        }
        .padding()
        .onAppear {
            locationViewModel.fetchCampingSites()
        }
        
//        ForEach(locationViewModel.campingSites, id: \.self) { campingSite in
//                    HStack{
//                        Text("Camping site:")
//                        Text(campingSite.name ?? "")
//                    }
//                }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
