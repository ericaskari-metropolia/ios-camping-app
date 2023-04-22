//
//  AddPlanModel.swift
//  camping
//
//  Created by Thu Hoang on 10.4.2023.
//

import Foundation
import MapKit

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct AddPlanCampsite: Identifiable, Codable {
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double
}

struct NewPlan {
    var startLocation: CLLocationCoordinate2D
    var destinationLocation: CampingSite
    var startDate: Date
    var endDate: Date
}
