//
//  WeatherCardView.swift
//  camping
//
//  Created by Binod Panta on 19.4.2023.
//

import SwiftUI

struct WeatherCardView: View {
    
    // A state variable that holds the weather forecast data
    @State var weatherForecast: Forecast
    
    // default value to show all weather info
    @State var startTimestamp: Int = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // Filter the weather data based on the startTimestamp and show data for the next 14 days
                ForEach(weatherForecast.list.filter({ $0.dt >= startTimestamp }).prefix(10), id: \.dt) { weatherList in
                    VStack(alignment: .leading) {
                        Text(formattedDate(from: weatherList.dt))
                        AsyncImage(url: weatherList.weather[0].weatherIconUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                        } placeholder: {
                            // if the image is still loading, show a ProgressView
                            ProgressView()
                        }
                        HStack {
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
                // If there is no weather data available for the next 14 days,show data for the next 14 days
                if weatherForecast.list.filter({ $0.dt >= startTimestamp }).count < 14 {
                    VStack{
                        Text("Weather data not available")
                            
                            .foregroundColor(.gray)
                            .padding()
                        Button("Show next 14 days") {
                            startTimestamp = Int(Date().timeIntervalSince1970)
                    }
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(Color.black)
                            .cornerRadius(15)
                   
                    }
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 15))
                    .padding()
                }
            }
            .padding()
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
