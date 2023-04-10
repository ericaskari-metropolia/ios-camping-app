//
//  Home.swift
//  camping
//
//  Created by Chi Nguyen on 3.4.2023.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    let url = "https://users.metropolia.fi/~thuh/camping.json"

    var body: some View {
        VStack{
            Color.white
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
            
        }.onAppear {
            Service().fetchCampingSites(url: url) { campingSites in
                print(campingSites)
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
