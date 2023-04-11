//
//  MyTripsFilledView.swift
//  camping
//
//  Created by Binod Panta on 11.4.2023.
//

/* This is a view that displays the trip of a user*/

import SwiftUI

struct MyTripsFilledView: View {
    
    let pastCards = Array(repeating: PastTripCard(), count: 3)
    var body: some View {
        VStack {
            ZStack(alignment:Alignment(horizontal: .leading, vertical: .bottom)){
               
                Image("header")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 400, maxHeight: 300)
                    .clipped()
               
                VStack{
                    //The location Espoo is hardcoded, need to be changed
                    Label("You are in Espoo", systemImage: "globe.europe.africa")
                      .font(.headline)
                         .foregroundColor(.white)
                         .padding(.bottom,5)
                        
                         
                      Text("My trips")
                          .font(.title)
                          .foregroundColor(.white)
                          .fontWeight(.bold)
                       
                }
                .padding()
                .padding(.bottom,10)
                }
            .padding(.bottom,-40)
          .ignoresSafeArea()
            
            
            ScrollView{
                VStack{
                    VStack(alignment: .leading) {
                        Text("Ongoing trips")
                            .font(.headline)
                            .padding(.horizontal,10)
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                ForEach(0..<4) {index in
                                    OngoingTripCard()
                                }
                            }
                        }
                    }
                    .padding(.top,0)
                    Label("Create new trip", systemImage: "plus")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                        .background(Color.black)
                        .cornerRadius(15)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("My Past Trips")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.bottom,-30)
                            Spacer()
                          
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        
                        
                    }
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 10)]) {
                        ForEach(0..<4) { index in
                                     PastTripCard()
                                    }
                             }
                    .padding(.horizontal,-10)
                    .padding()
                    
                    }
                }
            }
           
            Spacer()
        }
    
}

struct MyTripsFilledView_Previews: PreviewProvider {
    static var previews: some View {
        MyTripsFilledView()
    }
}
