//
//  WeatherConditionView.swift
//  camping
//
//  Created by The Minions on 17.4.2023.
//

import SwiftUI

struct WeatherConditionView: View {
    var weather: ResponseBody
    var body: some View {
        
        HStack(alignment: .top){
            
            Text("\("detail.date".i18n()) \(Date().formatted(.dateTime.month().day().hour().minute()))")
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
