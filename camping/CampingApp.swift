//
//  campingApp.swift
//  camping
//
//  Created by The Minions on 28.3.2023.
//

import SwiftUI

@main
struct CampingApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(LocationViewModel())
                .environmentObject(PlanViewModel())
                .environmentObject(GearViewModel())
                .environmentObject(MyTripViewModel())
        }
    }
}
