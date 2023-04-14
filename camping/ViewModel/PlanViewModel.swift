//
//  AddPlanViewModel.swift
//  camping
//
//  Created by Thu Hoang on 10.4.2023.
//
import CoreData
import Foundation
import MapKit
import SwiftUI

final class PlanViewModel: NSObject, ObservableObject {
    //  Saves Plan to Storage
    func savePlan(input: AddPlantFirstStepViewOutput) {
        let context = PersistenceController.shared.container.viewContext
        let plan = Plan(context: context)
        plan.campingSite = input.destinationLocation
        plan.startLatitude = input.startLocation.latitude
        plan.startLongitude = input.startLocation.longitude
        plan.startDate = input.startDate
        plan.endDate = input.endDate

        do {
            try context.save()
            print("Plan Saved!")
        } catch {
            print("Cannot save Plan.")
        }
    }
}
