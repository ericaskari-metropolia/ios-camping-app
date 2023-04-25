//
//  PlanNewTripButtonView.swift
//  camping
//
//  Created by Chi Nguyen on 15.4.2023.
//

import SwiftUI

struct PlanNewTripButtonView: View {
    var campsite: CampingSite?
    var completed: () -> ()

    var body: some View {
        NavigationLink(
            destination: AddPlanView(
                isDestinationLocationPassedFromParent: true,
                destinationLocation: campsite,
                completed: {
                    print("[PlanNewTripButtonView] completed")
                    completed()
                }
            ),
            label: {
                Text("Plan new trip")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
            }
        )
        .disabled(campsite == nil)
        .padding()
        .background(Color.primary)
        .clipShape(Capsule())
    }
}

struct PlanNewTripButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlanNewTripButtonView(completed: {
            print("[PlanNewTripButtonView_Previews] completed")

        }).environmentObject(LocationViewModel())
    }
}
