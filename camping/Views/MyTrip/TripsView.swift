//
//  Trips.swift
//  camping
//
//  Created by Chi Nguyen on 3.4.2023.
//

import SwiftUI

struct TripsView: View {
    
    // Use @Environment property wrapper to inject the managed object context into this view
    @Environment(\.managedObjectContext) var context
    
    // Use @StateObject property wrapper to create an instance of MyTripViewModel for this view
    @StateObject var viewModel = MyTripViewModel(context: PersistenceController.shared.container.viewContext)
    var body: some View {
        
        //*THIS CODE NEEDS A REVIEW
        
        // Check if there are any plans/trips
        if viewModel.hasPlans() {
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
