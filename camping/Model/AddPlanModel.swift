//
//  AddPlanModel.swift
//  camping
//
//  Created by Thu Hoang on 10.4.2023.
//

import Foundation

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

struct AddPlantFirstStepViewOutput {
    var startLocationText: String
    var destinationLocationText: String
    var startDate: Date?
    var endDate: Date?
}
