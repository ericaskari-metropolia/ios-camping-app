//
//  MyTripsEmptyView.swift
//  camping
//
//  Created by Binod Panta on 10.4.2023.
//

/* This view is displayed when the user doesnot have any trip plan yet.*/


import SwiftUI

struct MyTripsEmptyView: View {
    var body: some View {
        VStack {
            ZStack(alignment:Alignment(horizontal: .leading, vertical: .bottom)){
                
                Image("header")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 400, maxHeight: 350)
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
                .padding(.bottom,30)
            }
            
            .ignoresSafeArea()
            Spacer()
            VStack{
                Text("Ongoing trips")
                    .padding(.top,-55)
                    .padding(.leading, -180)
                    .fontWeight(.black)
                
                //Just a random image, I can change it later
                Image("no-plan")
                    .resizable()
                    .frame(maxWidth: 400, maxHeight: 250)
                    .padding(.top,-20)
                    .padding(.horizontal,20)
                Text("Oops!! You don't have any plans yet!!")
                    .padding(.bottom,20)
                Label("Create new trip", systemImage: "plus")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.black)
                    .cornerRadius(15)
                
                Spacer()
                
                
            }
        }
    }
}

struct MyTripsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        MyTripsEmptyView()
    }
}
