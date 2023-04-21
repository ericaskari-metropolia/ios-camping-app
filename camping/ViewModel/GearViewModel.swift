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

class GearViewModel: ObservableObject {
    //  Saves Plan to Storage
    func save(name: String, plan: Plan, checked: Bool = false) {
        let context = PersistenceController.shared.container.viewContext

        let gear = Gear(context: context)
        gear.id = UUID()
        gear.name = name
        gear.plan = plan
        gear.checked = checked

        do {
            try context.save()
            print("Gear Saved!")
        } catch {
            print("Cannot save Gear.")
        }
    }

    func deleteItems(gear: Gear) {
        let context = PersistenceController.shared.container.viewContext
        context.delete(gear)

        do {
            try context.save()
        } catch {
            print("Canno delete Gear.")
            let nsError = error as NSError
            print(nsError)
            print(nsError.userInfo)
        }
    }

    func addItem(name: String, plan: Plan, checked: Bool = false) {
        let context = PersistenceController.shared.container.viewContext
       
        withAnimation {
            let newItem = Gear(context: context)
            newItem.name = Date().description
            newItem.id = UUID()
            newItem.checked = checked
            newItem.plan = plan
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
