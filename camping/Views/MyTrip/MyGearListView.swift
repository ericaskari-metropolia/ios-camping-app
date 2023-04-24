//
//  MyGearListView.swift
//  camping
//
//  Created by Binod Panta on 23.4.2023.
//

import SwiftUI
import CoreData

struct MyGearListView: View {
    
    var plan: Plan
    @StateObject var gearViewModel: GearViewModel = .init()
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Gear.name, ascending: true)],
        animation: .default
    )
    private var allItems: FetchedResults<Gear>
    
    // let filteredItems = filterItems(forPlan: plan, fromAllItems: allItems)
    
    var body: some View {
        let filteredItems = filterItems()
        if filteredItems.count > 0 {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                VStack(spacing: -10) {
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
                        HStack (alignment: .center, spacing: 0){
                            Text("\(item.name ?? "-")")
                            Spacer()
                            Image(systemName: item.checked ? "checkmark.square.fill" : "square")
                                .foregroundColor(item.checked ? Color(UIColor.systemBlue) : Color.secondary)
                                .onTapGesture {gearViewModel.checkItem(gear: item)}
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)                }
                    
                }
            }
            NavigationLink(
                destination: AddPlanGears(plan:plan)
                    .environmentObject(GearViewModel()),
                label: {
                    Text("Edit gear")
                        .frame(maxWidth: .infinity)
                }
            )
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .cornerRadius(30)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                Text("You do not have any gears added!")
                    .padding()
            }
            .padding()
            NavigationLink(
                destination: AddPlanGears(plan:plan)
                    .environmentObject(GearViewModel()),
                label: {
                    Text("Add gear")
                        .frame(maxWidth: .infinity)
                }
            )
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .cornerRadius(30)
        }
        
        
    }
    func filterItems() -> [Gear] {
        return allItems.filter { gear in
            if gear.plan?.id == nil {
                return false
            }
            if plan.id == nil {
                return false
            }
            return gear.plan!.id!.uuidString == plan.id!.uuidString
        }
    }
}
//struct MyGearListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyGearListView()
//    }
//}
