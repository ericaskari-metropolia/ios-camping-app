//
//  TripsView.swift
//  camping
//
//  Created by The Minions on 19.4.2023.
//

import SwiftUI

struct TripsView: View {
    @FetchRequest(sortDescriptors: []) var plans: FetchedResults<Plan>
    
    var body: some View {
        // Check if there are any plans/trips
        if plans.count == 0 {
            MyTripsEmptyView()
        } else {
            MyTripsFilledView()
        }
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}
