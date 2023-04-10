//
//  ContentView.swift
//  camping
//
//  Created by Eric Askari on 28.3.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PermissionView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
