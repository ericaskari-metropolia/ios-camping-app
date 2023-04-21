//
//  GearListView.swift
//  camping
//
//  Created by Eric Askari on 19.4.2023.
//

import CoreData
import SwiftUI

struct AddPlanGears: View {
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

    var body: some View {
        VStack {
            List {
                TextField("Name", text: $gearName)
                ForEach(allItems.filter {
                    gear in
                    if gear.plan?.id == nil {
                        return false
                    }
                    if plan.id == nil {
                        return false
                    }
                    return gear.plan!.id!.uuidString == plan.id!.uuidString
                }) { item in
                    Text("\(item.name ?? "-")")
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
            indexSet.forEach { _ in
//                gearViewModel.deleteItems(gear: plans[index])
            }
        }
    }

    private func addItem() {
        if gearName == "" {
            return
        }
        withAnimation {
            let gear = gearViewModel.saveItem(name: gearName, plan: plan, checked: false)
            gearName = ""
        }
    }
}

// struct GearListView_Previews: PreviewProvider {
//    static var previews: some View {
//        GearListView().environmentObject(
//            GearViewModel()
//        )
//    }
// }
