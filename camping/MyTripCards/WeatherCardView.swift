//
//  WeatherCardView.swift
//  camping
//
//  Created by Binod Panta on 19.4.2023.
//

import SwiftUI

struct WeatherCardView: View {
    
    // A state variable that holds the weather forecast data
    @State var weatherForecast : Forecast
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 5) {
                
                // A loop to iterate over each day's weather information
                ForEach(weatherForecast.list.prefix(14), id: \.dt) { weatherList in
                    VStack(alignment: .leading,spacing: 10){
                        Text(formattedDate(from:weatherList.dt))
                        Image(systemName: "cloud")
                            .font(.title)
                        Text("\(Int(weatherList.temp.max - 273.15))°C / \(Int(weatherList.temp.min - 273.15))°C")
                        //Text(weatherList.weather.description)
                    }.padding()
                        .background(Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 15))
                        .padding()
                }
            }
        }
    }
    
        
    // A helper function to format the date of the forecasted weather
    func formattedDate(from timestamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
    }
}

//struct WeatherCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherCardView()
//    }
//}
