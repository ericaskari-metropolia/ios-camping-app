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
            ZStack{
                HeaderView()
                Text("My trips")
                    .bold()
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: -115, y: 60)
            }
            noTripsView
        }
        .edgesIgnoringSafeArea(.top)
    }
}


extension MyTripsEmptyView {
    
    private var noTripsView :some View {
        VStack(alignment: .center){
            Text("You don't have any plan yet")
                .bold()
            
            //Just a random image, I can change it later
            Image("no-plan")
                .resizable()
                .frame(maxWidth: 400, maxHeight: 250)
                .padding()
            
            PlanNewTripButtonView(campsite: nil) {
                Label("Create new trip", systemImage: "plus")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.black)
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
