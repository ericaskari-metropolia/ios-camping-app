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

// This class is responsible for interacting with CoreData stuff related to Gear
class GearViewModel: ObservableObject {
    let context = PersistenceController.shared.container.viewContext

    //  Save new Gear
    func saveItem(name: String, plan: Plan, checked: Bool = false) -> Gear? {
        let newItem = Gear(context: context)
        newItem.name = name
        newItem.id = UUID()
        newItem.checked = checked
        newItem.plan = plan

        do {
            try context.save()
            print("Gear Saved!")
            return newItem
        } catch {
            print("Cannot save Gear.")
            let nsError = error as NSError
            print(nsError)
            print(nsError.userInfo)
            return nil
        }
    }

    //  Delete Gear
    func deleteItem(gear: Gear) {
        context.delete(gear)

        do {
            try context.save()
            print("Gear Deleted!")
        } catch {
            print("Cannot delete Gear.")
            let nsError = error as NSError
            print(nsError)
            print(nsError.userInfo)
        }
    }
}
