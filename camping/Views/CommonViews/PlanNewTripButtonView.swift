//
//  PlanNewTripButtonView.swift
//  camping
//
//  Created by Chi Nguyen on 15.4.2023.
//

import SwiftUI

struct PlanNewTripButtonView<Content: View>: View {
    var campsite: CampingSite?
    var completed: () -> ()

    let label: Content

    init(campsite: CampingSite?, @ViewBuilder _ label: () -> Content, completed: @escaping () -> ()) {
        self.campsite = campsite
        self.label = label()
        self.completed = completed
    }

    var body: some View {
        NavigationLink(
            destination: AddPlanView(
                isDestinationLocationPassedFromParent: campsite != nil,
                destinationLocation: campsite,
                completed: {
                    print("[PlanNewTripButtonView] completed")
                    completed()
                }
            ),
            label: {
                label
            }
        )
    }
}

struct PlanNewTripButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlanNewTripButtonView(
            campsite: nil,
            {
                Text("Plan new trip")

            }, completed: {
                print("[PlanNewTripButtonView_Previews] completed")
            }
        )
    }
}
