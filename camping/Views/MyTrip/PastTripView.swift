//
//  PastTripView.swift
//  camping
//
//  Created by The Minions on 18.4.2023.
//
/* A view for displaying the past trips*/

import SwiftUI

struct PastTripView: View {
    
    // Use @EnvironmentObject property wrapper to inject an instance of MyTripViewModel into this view
    @EnvironmentObject var viewModel: MyTripViewModel
    
    
    var body: some View {
        VStack{
            
            // Show a scroll view of past trip cards using the planDetails provided by the view model
            PastTripScrollView(planDetails: viewModel.pastPlanDetails())
        }
        //when the view appears, fetch all the plans and update the plan details
        .onAppear {
            viewModel.planDetails = viewModel.fetchAllPlans()
        }
    }
}

struct PastTripScrollView: View {
    
    //An array of plandetail object
    let planDetails: [PlanDetail]
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 10) {
                
                //Looping through the array and create a tripdetail screen
                ForEach(planDetails) { planDetail in
                    NavigationLink(destination: {PastTripInfoView(planDetail:planDetail)}) {
                        MyPastTripCard(planDetail: planDetail)
                    }
                    
                    
                }
            }
            .padding(.horizontal, 20)
        }
    }
}


// A view for displaying a past trip card
struct MyPastTripCard: View {
    
    // Create a view model with a context
    @EnvironmentObject var viewModel: MyTripViewModel
    
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
                            .frame(width: 300, height: 200)
                            .frame(maxWidth: (UIScreen.main.bounds.width - 70))
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
