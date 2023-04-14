//
//  AddPlanOverview.swift
//  camping
//
//  Created by Eric Askari on 14.4.2023.
//

import SwiftUI

struct AddPlanOverview: View {
    //  To Access Plans and save them
    @StateObject private var viewModel = PlanViewModel()

    var input: AddPlantFirstStepViewOutput?
    var body: some View {
        VStack {
            Text(input?.startDate.description ?? "No Start date")
            Text(input?.endDate.description ?? "No End date")
            Text(input?.startLocation.latitude.description ?? "No Start latitude")
            Text(input?.startLocation.longitude.description ?? "No Start latitude")
            Text(input?.destinationLocation.name ?? "No Destination name")

            Button {
                viewModel.savePlan(input: input!)
            } label: {
                Text("Save")
            }
            .disabled(input == nil)
         
        }
    }
}

struct AddPlanOverview_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanOverview()
    }
}
