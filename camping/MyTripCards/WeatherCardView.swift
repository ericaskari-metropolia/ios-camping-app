//
//  WeatherCardView.swift
//  camping
//
//  Created by Binod Panta on 19.4.2023.
//

import SwiftUI

struct WeatherCardView: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
          Text("10 degrees")
            VStack{
                    Image(systemName: "cloud")
                    .font(.title)
                    
                    Text("15:00")
                        .foregroundColor(.blue)
                        .font(.headline)
                        .padding()
                }
        }
        .padding()
        .background(Rectangle()
            .foregroundColor(.white)
            .cornerRadius(20)
            .shadow(radius: 15))
        .padding()
    }
}

struct WeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCardView()
    }
}
