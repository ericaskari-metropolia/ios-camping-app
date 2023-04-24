//
//  MyGearListView.swift
//  camping
//
//  Created by Binod Panta on 23.4.2023.
//

import SwiftUI
import CoreData

struct MyGearListView: View {
    @StateObject var vm = GearViewModel()
    
    var plan : Plan
  
    var body: some View {
        VStack {

            List {
                if vm.fetchGear(for: plan).count > 0 {
                    ForEach(vm.fetchGear(for: plan)) { gear in
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
