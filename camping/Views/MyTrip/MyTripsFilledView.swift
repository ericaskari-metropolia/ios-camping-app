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
    
    // Use @EnvironmentObject property wrapper to inject an instance of LocationViewModel into this view
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    // Use @Environment property wrapper to inject the managed object context into this view
    @Environment(\.managedObjectContext) var context

    // Use @StateObject property wrapper to create an instance of MyTripViewModel for this view
    @StateObject var viewModel = MyTripViewModel(context: PersistenceController.shared.container.viewContext)
    
    @FetchRequest(sortDescriptors: []) var plans: FetchedResults<Plan>
    
   
    
    func countOfOngoingAndPastPlans() -> (ongoingCount: Int, pastCount: Int) {
           let currentDate = Date()
        let ongoingPlans = plans.filter { $0.endDate ?? currentDate >= currentDate }
           let pastPlans = plans.filter { $0.endDate ?? currentDate < currentDate }
           return (ongoingCount: ongoingPlans.count, pastCount: pastPlans.count)
       }
        
    var body: some View {
        VStack {
            headerView
                .padding(.bottom,-40)
                .ignoresSafeArea()
           
           
            ScrollView{
                // Check if there are any ongoing trips
                if countOfOngoingAndPastPlans().ongoingCount > 0 {
                    VStack{
                        Label("Ongoing trip", systemImage: "figure.run.circle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 350, height: 40)
                            .background(Color.cyan)
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
    private var headerView : some View {
        ZStack(alignment:Alignment(horizontal: .leading, vertical: .bottom)){
           
            Image("header")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 400, maxHeight: 300)
                .clipped()
           
            VStack(alignment: .leading){
               
                Label("You are in \(locationViewModel.currentPlacemark?.locality ?? "")", systemImage: "mappin.and.ellipse")
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
    
    
    // View to display when there are no ongoing trips
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
    
    // View to display when there are no past trips
    private var noPastTripsView :some View {
        VStack{
            Image("no-plan")
                .resizable()
                .frame(maxWidth: 400, maxHeight: 250)
                .padding(.top,20)
                .padding(.horizontal,20)
            Text("Oops!! You don't have any past trips!!")
                .padding(.bottom,20)
        }
    }
    
    private var pastTripViewHeader : some View {
        VStack(alignment: .leading){
            HStack{
                Label("Past trip", systemImage: "flag.square.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 40)
                    .background(Color.cyan)
                    .cornerRadius(15)
                Spacer()
              
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    
    // View to display add new trip button
    private var createNewTripButton: some View {
        PlanNewTripButtonView(campsite: nil) {
            Label("Create new trip", systemImage: "plus")
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color.black)
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
