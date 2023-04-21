//
//  GearListView.swift
//  camping
//
//  Created by Eric Askari on 19.4.2023.
//

import CoreData
import SwiftUI

struct GearListView: View {
    var gearViewModel: GearViewModel = .init()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Gear.name, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Gear>

    @ObservedObject private var viewModel: GearViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { _ in
                    NavigationLink {
                        Text("Item at ")
                    } label: {
                        Text("Label")
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    gearViewModel.deleteItems(offsets: indexSet, items: items)
                })
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: gearViewModel.addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
            Text("Select an item")
        }
    }
}

//struct GearListView_Previews: PreviewProvider {
//    static var previews: some View {
//        GearListView().environmentObject(
//            GearViewModel()
//        ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
