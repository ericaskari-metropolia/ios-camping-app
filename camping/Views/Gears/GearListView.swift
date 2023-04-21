//
//  GearListView.swift
//  camping
//
//  Created by Eric Askari on 19.4.2023.
//

import CoreData
import SwiftUI

struct GearListView: View {
    @StateObject var gearViewModel: GearViewModel = .init()
    var plan: Plan?

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Gear.name, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Gear>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at ")
                    } label: {
                        Text(item.name ?? "-")
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    deleteItems(offsets: indexSet)
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        addItem()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.forEach { index in
                gearViewModel.deleteItems(gear: items[index])
            }
        }
    }

    private func addItem() {
        if (plan != nil) {
            withAnimation {
                gearViewModel.addItem(name: "Some", plan: plan!, checked: false)
            }
        }
        
    }
}

 struct GearListView_Previews: PreviewProvider {
    static var previews: some View {
        GearListView().environmentObject(
            GearViewModel()
        )
    }
 }

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
