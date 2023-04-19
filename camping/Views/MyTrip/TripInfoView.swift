//
//  TripInfoView.swift
//  camping
//
//  Created by Binod Panta on 19.4.2023.
//

import SwiftUI

struct TripInfoView: View {
    var body: some View {
        VStack{
                    ZStack(alignment: .top){
                        Image("mytripimg")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                        
                        VStack(spacing: 0.0){
                            HStack {
                                Button{
                                } label: {
                                    Image(systemName: "chevron.left.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        
                                }
                                
                                Spacer()
                                
                                Text("Trip information")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    
                                
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 50, leading: 40, bottom: 0, trailing: 40))
                        }
                        
                    }
                    .background(Color.clear)
                    .ignoresSafeArea()
            HStack{
                Text("Kokkola Camping Finland")
                    .font(.title3)
                    .fontWeight(.bold)
                    Spacer()
                Image(systemName: "tent")
            } .padding()
                .padding(.top,-40)
            
            HStack{
               Label("16 April 2023 - 25 April 2023 ", systemImage:"calendar")
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "note.text")
            }.padding()
                .padding(.top,-10)
           
            VStack(alignment: .leading){
                Text("Weather Forecast")
                    .multilineTextAlignment(.leading)
                
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        
                        ForEach(0..<5) { index in
                            WeatherCardView()
                        }}
                    .padding(.horizontal,0)
                }
            }.padding(.vertical,0)
                .padding(.horizontal,15)
           
            Label("Gear List", systemImage: "list.bullet")
            
            Text("Oops!! you dont have any gears added.")
            Spacer()
            Label("Add Gear", systemImage: "plus")
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color.black)
                .cornerRadius(15)
            
        }
    }
}

struct TripInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TripInfoView()
    }
}
