//
//  Service.swift
//  camping
//
//  Created by Thu Hoang on 5.4.2023.
//

import Foundation

// Fetch data JSON from network
class Service {
    func fetchCampingSites(url: String, completion: @escaping ([CampingSiteData]) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let campingSite = try JSONDecoder().decode([CampingSiteData].self, from: data)
                completion(campingSite)
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        }.resume()
    }
}
