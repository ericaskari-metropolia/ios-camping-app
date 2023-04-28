//
//  ForecastModel.swift
//  camping
//
//  Created by The Minions on 19.4.2023.
//
/* A struct to represent the forecast data, including the city, count, and a list of weather data */

import Foundation

struct Forecast : Codable {
    var city: City
    var cnt: Int
    var list: [WeatherList]
    
}

struct City: Codable {
    var coord: Coord
}
struct Coord: Codable {
    var lon: Double
    var lat: Double
}

struct WeatherList : Codable{
    var dt: Int
    var temp: Temp
    var feels_like: FeelsLike
    var weather: [WeatherDesc]
    
}
struct WeatherDesc :Codable {
    var main: String
    var description: String
    var icon :String
    
    var weatherIconUrl : URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        
        return URL(string: urlString)!
    }
}

struct Temp: Codable {
    var min: Double
    var max: Double
}

struct FeelsLike: Codable {
    var day: Double
}
