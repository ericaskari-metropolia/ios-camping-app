//
//  TabView.swift
//  camping
//
//  Created by Thu Hoang on 7.4.2023.
//

import SwiftUI
import CoreData

struct NavigationTabView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        TabView{
            HomeView()
                .tabItem(){
                    Image(systemName: "globe")
                    Text("Discovery")
                }
                .environmentObject(locationViewModel)
            AddPlanView()
                .tabItem(){
                    Image(systemName: "plus")
                    Text("Add plan")
                }
            
            FavoriteView()
                .tabItem(){
                    Image(systemName: "heart")
                    Text("Saved locations")
                }
            
            TripsView()
                .tabItem(){
                    Image(systemName: "road.lanes")
                    Text("Trips")
                }
            
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}


struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView()
        //            .environmentObject(LocationViewModel())
        //            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
