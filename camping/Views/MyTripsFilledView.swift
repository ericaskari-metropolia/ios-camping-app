//
//  MyTripsFilledView.swift
//  camping
//
//  Created by Binod Panta on 11.4.2023.
//

/* This is a view that displays the trip of a user*/

import SwiftUI
import CoreData

struct MyTripsFilledView: View {
    
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[])
    var campResults: FetchedResults<CampingSite>
    
    @State var onGoingTrip:Bool = false
    var body: some View {
        VStack {
            headerView
                .padding(.bottom,-40)
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    if onGoingTrip {
                        VStack(alignment: .leading){
                            Text("Ongoing trips")
                                .font(.headline)
                                .padding(.top,-20)
                                .padding()
                            NoTripCard()
                        }
                        
                    } else {
                        VStack(alignment: .leading){
                            Text("Ongoing trips")
                                .font(.headline)
                                .padding(.top,-20)
                                .padding()
                            OnGoingTripView()
                        }
                    }
                    
                    Divider()
                    createNewTripButton
                    pastTripViewHeader
                    pastTripGridView
                        .padding(.horizontal,-10)
                        .padding()
                    
                }
            }
        }
    }
    
}

extension MyTripsFilledView {
    private var headerView : some View {
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
    }
    
    private var onGoingTripView : some View {
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
    }
    
    private var noOngoingTripsView :some View {
        VStack{
            Image("no-plan")
                .resizable()
                .frame(maxWidth: 400, maxHeight: 250)
                .padding(.top,-20)
                .padding(.horizontal,20)
            Text("Oops!! You don't have any ongoing trips!!")
                .padding(.bottom,20)
        }
    }
    
    private var pastTripViewHeader : some View {
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
    }
    
    private var createNewTripButton : some View {
        Label("Create new trip", systemImage: "plus")
            .foregroundColor(.white)
            .frame(width: 350, height: 50)
            .background(Color.black)
            .cornerRadius(15)
    }
    private var campData :some View {
        VStack{
            Text("camp data")
            if campResults.isEmpty {
                Text("Camp Result is empty")
            } else {
                List {
                    ForEach(campResults) {camp in
                        Text(camp.city ?? "Helsinki")
                            .font(.title)
                            .frame(width: 80, height: 80)
                        
                    }
                }
                
            }
        }
    }
    
    
    private var pastTripGridView : some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 10)]) {
            ForEach(0..<4) { index in
                         PastTripCard()
                        }
                 }
    }
}

struct MyTripsFilledView_Previews: PreviewProvider {
    static var previews: some View {
        MyTripsFilledView()
    }
}
