//
//  AddPlanViewModel.swift
//  camping
//
//  Created by Eric Askari on 10.4.2023.
//
import CoreData
import Foundation
import MapKit
import SwiftUI

// This class is responsible for interacting with CoreData stuff related to Plan
final class PlanViewModel: NSObject, ObservableObject {
    let context = PersistenceController.shared.container.viewContext

    //  Saves Plan to Storage
    func savePlan(input: NewPlan) -> Plan? {
        let plan = Plan(context: context)
        plan.id = UUID()
        plan.campingSite = input.destinationLocation
        plan.startLatitude = input.startLocation.latitude
        plan.startLongitude = input.startLocation.longitude
        plan.startDate = input.startDate
        plan.endDate = input.endDate

        do {
            try context.save()
            print("Plan Saved!")
            return plan
        } catch {
            print("Cannot save Plan.")
            return nil
        }
    }
}
