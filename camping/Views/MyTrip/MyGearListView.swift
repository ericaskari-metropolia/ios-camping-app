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
    @EnvironmentObject var gearViewModel: GearViewModel

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
                    ForEach(filteredItems.indices, id: \.self) { index in
                        HStack (alignment: .center, spacing: 0){
                            Text("\(filteredItems[index].name ?? "-")")
                            Spacer()
                            Image(systemName: filteredItems[index].checked ? "checkmark.square.fill" : "square")
                                .foregroundColor(filteredItems[index].checked ? Color(UIColor.systemBlue) : Color.secondary)
                                .onTapGesture {gearViewModel.checkItem(gear: filteredItems[index])}
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(index % 2 == 0 ? Color.white.cornerRadius(10) : Color.gray.opacity(0.1).cornerRadius(10))
                       
                    }
                }
            }

            NavigationLink(
                destination: AddPlanGears(plan:plan),
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
                destination: AddPlanGears(plan:plan),
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
