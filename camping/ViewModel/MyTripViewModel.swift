//
//  MyTripViewModel.swift
//  camping
//
//  Created by Binod Panta on 18.4.2023.
//

import Foundation
import CoreData
import MapKit

//class MyTripViewModel: ObservableObject {
//    @Published var pastPlans: [AddPlantFirstStepViewOutput] = []
//    @Published var upcomingPlans: [AddPlantFirstStepViewOutput] = []
//    @Published var campingSites: [CampingSite] = []
//
//    private let context: NSManagedObjectContext
//
//        init(context: NSManagedObjectContext) {
//            self.context = context
//        }
//
//    func fetchAllPlans() -> [Plan] {
//
//           let fetchRequest = NSFetchRequest<Plan>(entityName: "Plan")
//
//           do {
//               let plans = try context.fetch(fetchRequest)
//               print(plans)
//               return plans
//           } catch {
//               print("Error fetching plans: \(error)")
//               return []
//           }
//       }
//    func fetchPlans() -> (pastPlans: [AddPlantFirstStepViewOutput], upcomingPlans: [AddPlantFirstStepViewOutput]) {
//        let plans = fetchAllPlans()
//        let now = Date()
//
//        let pastPlans = plans.filter { $0.endDate! < now }
//                              .map { AddPlantFirstStepViewOutput(startLocation: CLLocationCoordinate2D(latitude: $0.startLatitude, longitude: $0.startLongitude),
//                                                                 destinationLocation: $0.campingSite!,
//                                                                startDate: $0.startDate!,
//                                                                endDate: $0.endDate!) }
//
//        let upcomingPlans = plans.filter { $0.startDate! >= now }
//                                  .map { AddPlantFirstStepViewOutput(startLocation: CLLocationCoordinate2D(latitude: $0.startLatitude, longitude: $0.startLongitude),
//                                                                    destinationLocation: $0.campingSite!,
//                                                                    startDate: $0.startDate!,
//                                                                    endDate: $0.endDate!) }
//
//        return (pastPlans: pastPlans, upcomingPlans: upcomingPlans)
//    }
//    func fetchAllCampingSites() -> [CampingSite] {
//           let fetchRequest = NSFetchRequest<CampingSite>(entityName: "CampingSite")
//
//           do {
//               let campingSites = try context.fetch(fetchRequest)
//               return campingSites
//           } catch {
//               print("Error fetching camping sites: \(error)")
//               return []
//           }
//       }
//
//}

class MyTripViewModel: ObservableObject {
    @Published var planDetails: [PlanDetail] = []
    @Published var campingSites: [CampingSite] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchAllPlans() -> [PlanDetail] {
        let fetchRequest: NSFetchRequest<Plan> = Plan.fetchRequest()
        do {
              let plans = try context.fetch(fetchRequest)
              let planDetails = plans.compactMap { (plan: Plan) -> PlanDetail? in
                  guard let destination = plan.campingSite else { return nil }
                  let start = plan.startDate ?? Date()
                  let end = plan.endDate ?? Date()
                  let imageURL = destination.imageURL ?? ""
                  return PlanDetail(destination: destination, start: start, end: end, imageURL: imageURL)
              }
              return planDetails
          } catch {
              print("Error fetching plans: \(error)")
              return []
          }    }

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
    
    func countOfOngoingAndPastPlans() -> (ongoingCount: Int, pastCount: Int) {
           let currentDate = Date()
           let ongoingPlans = planDetails.filter { $0.end >= currentDate }
           let pastPlans = planDetails.filter { $0.end < currentDate }
           return (ongoingCount: ongoingPlans.count, pastCount: pastPlans.count)
       }
}

struct PlanDetail:Identifiable {
   
    
    var destination: CampingSite
    var start: Date
    var end: Date
    var imageURL: String
    
    var id: String {
        return imageURL
        
    }
}

