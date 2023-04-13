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
    func savePlan(campingSite: CampingSite, startDate: Date, endDate: Date) {
        let context = PersistenceController.shared.container.viewContext
        let plan = Plan(context: context)
        plan.campingSite = campingSite
        plan.startDate = startDate
        plan.endDate = endDate

        do {
            try context.save()
            print("Plan Saved!")
        } catch {
            print("Cannot save Plan.")
        }
    }

}
