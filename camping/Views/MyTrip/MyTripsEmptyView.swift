//
//  MyTripsEmptyView.swift
//  camping
//
//  Created by The Minions on 10.4.2023.
//
/* This view is displayed when the user doesnot have any trip plan yet.*/


import SwiftUI

struct MyTripsEmptyView: View {
    var body: some View {
        VStack {
            HeaderView(title: "My trips")
            noTripsView
        }
        .edgesIgnoringSafeArea(.top)
    }
}

extension MyTripsEmptyView {
    
    private var noTripsView :some View {
        VStack(alignment: .center){
            Text("label.onGoingTrip")
                .bold()
                .foregroundColor(Color("PrimaryColor"))
            
            //Just a random image, I can change it later
            Image("no-plan")
                .resizable()
                .frame(maxWidth: 400, maxHeight: 250)
                .padding()
            
            PlanNewTripButtonView(campsite: nil) {
                Label("action.createNewTrip", systemImage: "plus")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(15)
            } completed: {
                // Nothing to do
            }
            
            Spacer()
        }
        .padding()
    }
}


struct MyTripsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        MyTripsEmptyView()
            .environmentObject(LocationViewModel())
    }
}
