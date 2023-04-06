//
//  ContentView.swift
//  camping
//
//  Created by Eric Askari on 28.3.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    

    var body: some View {
        TabView{
            Home()
                .tabItem(){
                    Image(systemName: "globe")
                    Text("Discovery")
                }
            AddPlan()
                .tabItem(){
                    Image(systemName: "plus")
                    Text("Add plan")
                }

            Favorite()
                .tabItem(){
                    Image(systemName: "heart")
                    Text("Saved locations")
                }

            Trips()
                .tabItem(){
                    Image(systemName: "road.lanes")
                    Text("Trips")
                }

        }
        
    }

    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
