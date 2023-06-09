//
//  MyTripsFilledView.swift
//  camping
//
//  Created by The Minions on 11.4.2023.
//
/* This is a view that displays the trip of a user*/

import SwiftUI
import CoreData

struct MyTripsFilledView: View {
    
    // Use @EnvironmentObject property wrapper to inject an instance of LocationViewModel into this view
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    // Use @EnvironmentObject property wrapper to inject an instance of MyTripViewModel into this view
    @EnvironmentObject var viewModel: MyTripViewModel
    
    //fetch the plans
    @FetchRequest(sortDescriptors: []) var plans: FetchedResults<Plan>
    
    
    // A helper function to separate the ongoing and past plan
    func countOfOngoingAndPastPlans() -> (ongoingCount: Int, pastCount: Int) {
        let currentDate = Date()
        let ongoingPlans = plans.filter { $0.endDate ?? currentDate >= currentDate }
        let pastPlans = plans.filter { $0.endDate ?? currentDate < currentDate }
        return (ongoingCount: ongoingPlans.count, pastCount: pastPlans.count)
    }
    
    var body: some View {
        VStack {
            HeaderView(title: "label.myTrips".i18n())
                .padding(.bottom,-40)
                .ignoresSafeArea()
            
            ScrollView{
                // Check if there are any ongoing trips
                if countOfOngoingAndPastPlans().ongoingCount > 0 {
                    VStack{
                        Label("label.onGoingTrip".i18n(), systemImage: "figure.run.circle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 350, height: 40)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(15)
                        OnGoingTripView()
                    }
                } else {
                    noOngoingTripsView
                }
                Divider()
                createNewTripButton
                
                
                Divider()
                pastTripViewHeader
                
                
                // Check if there are any past trips
                if countOfOngoingAndPastPlans().pastCount > 0 {
                    PastTripView()
                        .padding(.horizontal,-10)
                        .padding()
                }else {
                    noPastTripsView
                    
                }
                
            }
        }
        
    }
    
}

// Extension to MyTripsFilledView containing private helper views
extension MyTripsFilledView {
    // View to display when there are no ongoing trips
    private var noOngoingTripsView :some View {
        VStack{
            Image("no-plan")
                .resizable()
                .frame(maxWidth: 400, maxHeight: 250)
                .padding(.top,-20)
                .padding(.horizontal,20)
            Text("label.noOnGoingTripsAlert".i18n())
                .padding(.bottom,20)
                .foregroundColor(Color("PrimaryColor"))
        }
    }
    
    // View to display when there are no past trips
    private var noPastTripsView :some View {
        VStack{
            Image("no-plan")
                .resizable()
                .frame(maxWidth: 400, maxHeight: 250)
                .padding(.top,20)
                .padding(.horizontal,20)
            Text("label.noPastTripsAlert".i18n())
                .padding(.bottom,20)
                .foregroundColor(Color("PrimaryColor"))
        }
    }
    
    private var pastTripViewHeader : some View {
        VStack(alignment: .leading){
            HStack{
                Label("label.pastTrips".i18n(), systemImage: "flag.square.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 40)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(15)                
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    
    // View to display add new trip button
    private var createNewTripButton: some View {
        PlanNewTripButtonView(campsite: nil) {
            Label("action.createNewTrip".i18n(), systemImage: "plus")
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color("PrimaryColor"))
                .cornerRadius(15)
        } completed: {
            // Nothing to do
        }
    }
}

struct MyTripsFilledView_Previews: PreviewProvider {
    static var previews: some View {
        MyTripsFilledView()
            .environmentObject(LocationViewModel())
    }
}
