//
//  PastTripView.swift
//  camping
//
//  Created by Binod Panta on 18.4.2023.
//
/* A view for displaying the past trips*/

import SwiftUI

struct PastTripView: View {
    
    // Create a view model with a context
    @StateObject var viewModel = MyTripViewModel(context: PersistenceController.shared.container.viewContext)
    
    
    var body: some View {
        VStack{
            
            // Show a grid of past trip cards using the planDetails provided by the view model
            PastTripGridView(planDetails: viewModel.pastPlanDetails())
        }
        //when the view appears, fetch all the plans and update the plan details
        .onAppear {
            viewModel.planDetails = viewModel.fetchAllPlans()
        }
    }
}


// A view for displaying a grid of past trip cards
struct PastTripGridView: View {

    // An array of planDetails to be used to create the past trip cards
    let planDetails: [PlanDetail]
    
    var body: some View {
        
        // Use a LazyVGrid to create a grid of past trip cards having 2 columns
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 10)]) {
            ForEach(planDetails) { planDetail in
                NavigationLink(destination: {PastTripInfoView(planDetail:planDetail)}){
                    MyPastTripCard(planDetail: planDetail)

                }
                            }
        }
    }
}


// A view for displaying a past trip card
struct MyPastTripCard: View {
    
    // Create a view model with a context
    @StateObject var viewModel = MyTripViewModel(context: PersistenceController.shared.container.viewContext)
   
    // A PlanDetail object to be used to create the past trip card
    let planDetail: PlanDetail
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            ZStack{
                
                // Display an AsyncImage with the URL of the destination image
                if let imgURL = URL(string: planDetail.imageURL) {
                    AsyncImage(url: imgURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200,height: 140)
                            .frame(maxWidth: (UIScreen.main.bounds.width - 100) / 2)
                            .cornerRadius(15)
                    } placeholder: {
                        // if the image is still loading, show a ProgressView
                        ProgressView()
                    }
                }
            }
            VStack(alignment: .leading){
                Text(planDetail.destination.name ?? "")
                    .font(.caption)
                    .fontWeight(.black)
                
                Text(timeAgo(from: planDetail.end))
                    .foregroundColor(.blue)
                    .font(.caption)
                    .padding(.top,2)
                    
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


//A function that handles the time ago feature
func timeAgo(from date: Date) -> String {
    let calendar = Calendar.current
    let now = Date()
    let components = calendar.dateComponents([.month], from: date, to: now)
    if let months = components.month, months > 0 {
        return "\(months) month\(months > 1 ? "s" : "") ago"
    } else {
        return "Less than a month ago"
    }
}
