//
//  CampsiteCategory.swift
//  camping
//
//  Created by The Minions on 6.4.2023.
//

import Foundation

// MARK: - CAMPSITE DATA CATEGORY MODEL

struct Category: Codable, Identifiable  {
    var id: Int
    var title: String
    var image: String 
}


// MARK: - FUNCTION TO DECODE JSON FILE
extension Bundle{
    func decode<T: Codable>(_ file: String) -> T {
        // Locate the JSON file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in the project.")
        }
        
        // Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in the project.")
        }
        
        // Create a decoder
        let decoder = JSONDecoder()
        
        // Create a property for the decoded data
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) in the project.")
        }
        
        // Return data
        return decodedData
    }
}

 
