//
//  MyGearListView.swift
//  camping
//
//  Created by Binod Panta on 23.4.2023.
//

import SwiftUI

struct MyGearListView: View {
    @StateObject var gearViewModel = GearViewModel()
    @State var planDetail:PlanDetail
    
    var body: some View {
        VStack {
            
            List {
                if gearViewModel.fetchGears(for: planDetail).count > 0 {
                    ForEach(gearViewModel.fetchGears(for: planDetail)) { gear in
                        Text(gear.name ?? "No gears")
                    }
                } else {
                    Text("No gears")
                }
                
            }
        }
    }
}
//struct MyGearListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyGearListView()
//    }
//}
