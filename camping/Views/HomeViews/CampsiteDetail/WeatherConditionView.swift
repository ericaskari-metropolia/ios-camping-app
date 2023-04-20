//
//  WeatherConditionView.swift
//  camping
//
//  Created by Chi Nguyen on 17.4.2023.
//

import SwiftUI

struct WeatherConditionView: View {
    var weather: ResponseBody
    var body: some View {
        
        HStack(alignment: .top){
            
            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .padding()
            
            Spacer()
        
            VStack {
                Text(weather.weather[0].main)
                Text(weather.main.feelsLike.roundedDouble() + "°")
                            .font(.title)
            }
        }
    }
}

//struct WeatherConditionView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherConditionView(weather: previewWeather )
//    }
//}
