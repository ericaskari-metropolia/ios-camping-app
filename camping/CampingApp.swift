//
//  campingApp.swift
//  camping
//
//  Created by Eric Askari on 28.3.2023.
//

import SwiftUI

@main
struct CampingApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var favoriteManager = FavoriteManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(favoriteManager)
        }
    }
}
