//
//  WeatherForecast.swift
//  camping
//
//  Created by The Minions on 19.4.2023.
//
import Foundation
import CoreLocation

class WeatherForecast {
    // API Key, add your own
    let apiKey = "97999a9cada722ce4e59802bc6f66394"
    
    func getWeatherForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> Forecast {
        guard let url = URL(string: "https://pro.openweathermap.org/data/2.5/forecast/climate?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)")
        else {
            fatalError("Error with weather url")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error when fetching current weather")
        }
        
        let decodedData = try JSONDecoder().decode(Forecast.self, from: data)
        
        return decodedData
    }
}
