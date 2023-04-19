//
//  MyTripViewModel.swift
//  camping
//
//  Created by Binod Panta on 18.4.2023.
//
/* This is the view model that handles the data for the My Trips feature */

import Foundation
import CoreData
import MapKit


class MyTripViewModel: ObservableObject {
    // Published properties that can be observed for changes
    @Published var planDetails: [PlanDetail] = []
    @Published var campingSites: [CampingSite] = []

    // The context used for Core Data operations
    private let context: NSManagedObjectContext

    // The initializer for the view model
    init(context: NSManagedObjectContext) {
        self.context = context
    }

// A function that fetches all the plans from Core Data and converts them to PlanDetails
    func fetchAllPlans() -> [PlanDetail] {
        let fetchRequest: NSFetchRequest<Plan> = Plan.fetchRequest()
        do {
              let plans = try context.fetch(fetchRequest)
              let planDetails = plans.compactMap { (plan: Plan) -> PlanDetail? in
                  
                  // For each plan, we create a PlanDetail object that contains the plan's details
                  guard let destination = plan.campingSite else { return nil }
                  let start = plan.startDate ?? Date()
                  let end = plan.endDate ?? Date()
                  let imageURL = destination.imageURL ?? ""
                  return PlanDetail(destination: destination, start: start, end: end, imageURL: imageURL)
              }
              return planDetails
          } catch {

              // If there is an error fetching the plans, we return an empty array
              print("Error fetching plans: \(error)")
              return []
          }    }

    // A function that fetches all the camping sites from Core Data
    func fetchAllCampingSites() -> [CampingSite] {
        let fetchRequest: NSFetchRequest<CampingSite> = CampingSite.fetchRequest()
        do {
            let campingSites = try context.fetch(fetchRequest)
            return campingSites
        } catch {
            print("Error fetching camping sites: \(error)")
            return []
        }
    }
    
    // A function that returns an array of PlanDetails for ongoing plans
    func ongoingPlanDetails() -> [PlanDetail] {
           let currentDate = Date()
           return planDetails.filter { $0.end >= currentDate }
       }
       
    
    // A function that returns an array of PlanDetails for past plans
       func pastPlanDetails() -> [PlanDetail] {
           let currentDate = Date()
           return planDetails.filter { $0.end < currentDate }
       }
    
    // A function that returns the count of ongoing and past plans
    func countOfOngoingAndPastPlans() -> (ongoingCount: Int, pastCount: Int) {
           let currentDate = Date()
           let ongoingPlans = planDetails.filter { $0.end >= currentDate }
           let pastPlans = planDetails.filter { $0.end < currentDate }
           return (ongoingCount: ongoingPlans.count, pastCount: pastPlans.count)
       }
    
    // A function that returns a Boolean indicating if there are any plans or not
    func hasPlans() -> Bool {
        return !planDetails.isEmpty
    }
}

// The PlanDetail struct that represents the details of a plan
struct PlanDetail:Identifiable {
   
    
    var destination: CampingSite
    var start: Date
    var end: Date
    var imageURL: String
    
    var id: String {
        return imageURL
        
    }
}

