//
//  TabView.swift
//  camping
//
//  Created by Thu Hoang on 7.4.2023.
//

import CoreData
import SwiftUI

// View for TabView contains navigation bar for tha app

struct NavigationTabView: View {
    @State private var tabSelection = 1

    @EnvironmentObject var locationViewModel: LocationViewModel

    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Discovery")
                }
                .tag(1)
                .environmentObject(locationViewModel)
            AddPlanView(completed: {
                print("Changing tab selection")
                self.tabSelection = 1
            })
            .tabItem {
                Image(systemName: "plus")
                Text("Add plan")
            }
            .tag(2)

            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Saved locations")
                }
                .tag(3)

            TripsView()
                .tabItem {
                    Image(systemName: "road.lanes")
                    Text("Trips")
                }
                .tag(4)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView()
                    .environmentObject(LocationViewModel())
                    .environmentObject(FavoriteManager())
    }
}
