//
//  GearListView.swift
//  camping
//
//  Created by Eric Askari on 19.4.2023.
//

import CoreData
import SwiftUI

struct GearListView: View {
    //    Inputs
    var plan: Plan

    //    States
    @StateObject var gearViewModel: GearViewModel = .init()
    @State var gearName: String = ""

    //    Data
    @FetchRequest(
         sortDescriptors: [NSSortDescriptor(keyPath: \Gear.name, ascending: true)],
         animation: .default
     )
     private var allItems: FetchedResults<Gear>
    
    @FetchRequest private var items: FetchedResults<Gear>

    init(plan: Plan) {
        self.plan = plan
        
        self._items = FetchRequest<Gear>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Gear.name, ascending: true)],
            predicate: NSPredicate(format: "plan = %@", plan),
            animation: .default
        )
    }
    
    var body: some View {
        VStack {
            List {
                Text("allItems: \(allItems.count)")
                Text("items: \(items.count)")
                TextField("Placeholder", text: $gearName)
                ForEach(items) { item in
                    Text("\(item.name ?? "-") \(item.plan?.id?.uuidString ?? "-")")
                }
                .onDelete(perform: {
                    indexSet in
                    deleteItems(indexSet: indexSet)
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
        }
    }

    private func deleteItems(indexSet: IndexSet) {
        withAnimation {
            indexSet.forEach { index in
                gearViewModel.deleteItems(gear: items[index])
            }
        }
    }

    private func addItem() {
        withAnimation {
            gearViewModel.addItem(name: gearName, plan: plan, checked: false)
            gearName = ""
        }
    }
}

//struct GearListView_Previews: PreviewProvider {
//    static var previews: some View {
//        GearListView().environmentObject(
//            GearViewModel()
//        )
//    }
//}
