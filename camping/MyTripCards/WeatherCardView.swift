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
            HStack{
                
                // A loop to iterate over each day's weather information
                ForEach(weatherForecast.list.prefix(14), id: \.dt) { weatherList in
                    VStack(alignment: .leading){
                        Text(formattedDate(from:weatherList.dt))
                        AsyncImage(url: weatherList.weather[0].weatherIconUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                        } placeholder: {
                        // if the image is still loading, show a ProgressView
                            ProgressView()
                        }
                        HStack{
                            Text("Max: \(Int(weatherList.temp.max - 273.15))°C ")
                            Spacer()
                            Text("Min: \(Int(weatherList.temp.min - 273.15))°C")
                                 }
                      
                        
                        Text(weatherList.weather[0].description.uppercased())
                    }.padding(10)
                        .background(Rectangle()
                            .foregroundColor(Color(red: 135/255, green: 206/255, blue: 235/255))
                            .cornerRadius(20)
                            .shadow(radius: 10))
                        .padding(5)
                }
            }
        }
        .padding()
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
