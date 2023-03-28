//
//  campingApp.swift
//  camping
//
//  Created by Eric Askari on 28.3.2023.
//

import SwiftUI

@main
struct campingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
