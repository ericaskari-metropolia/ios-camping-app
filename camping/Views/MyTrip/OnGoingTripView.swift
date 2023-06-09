//
//  OnGoingTripView.swift
//  camping
//
//  Created by The Minions on 18.4.2023.
//
/* A view that displays the ongoingtrip*/

import SwiftUI


struct OnGoingTripView: View {
    
    // Use @EnvironmentObject property wrapper to inject an instance of MyTripViewModel into this view
    @EnvironmentObject var viewModel: MyTripViewModel
    
    var body: some View {
        VStack {
            OnGoingTripScrollView(planDetails: viewModel.ongoingPlanDetails())
        }
        
        //when the view appears, fetch all the plans and update the plandetails
        .onAppear {
            viewModel.planDetails = viewModel.fetchAllPlans()
        }
    }
}

struct OnGoingTripScrollView: View {
    
    //An array of plandetail object
    let planDetails: [PlanDetail]
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 0) {
                
                //Looping through the array and create a tripdetail screen
                ForEach(planDetails) { planDetail in
                    NavigationLink(destination: {TripInfoView(planDetail:planDetail)}) {
                        OnGoingTripDetailScreen(planDetail: planDetail)
                    }
                    
                    
                }
            }
            
            .padding(.horizontal, 12)
        }
        
    }
}

struct OnGoingTripDetailScreen: View {
    
    // A single plan detail object
    let planDetail: PlanDetail
    
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    @State private var isEditing = false
    @State private var isDeleting = false
    
    @EnvironmentObject var viewModel: MyTripViewModel
    
    
    var body: some View {
        
        //Navigate to edit plan view
        NavigationLink(destination: EditPlanView(planDetail: planDetail), isActive: $isEditing) {
            EmptyView()
        }
        
        //Navigate to delete plan view
        NavigationLink(destination: DeletePlanView(planDetail: planDetail), isActive: $isDeleting) {
            EmptyView()
        }
        
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                
                //convert string into URL if not nil
                if let imgURL = URL(string: planDetail.imageURL) {
                    //create an AsyncImage with the URL
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
                    .overlay(
                        HStack {
                            Button(action: {
                                showingActionSheet = true
                            }) {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .padding()
                            }
                            .actionSheet(isPresented: $showingActionSheet) {
                                ActionSheet(title: Text("label.chooseAction".i18n()), buttons: [
                                    .default(Text("action.edit".i18n())) {
                                        // Navigate to the edit plan screen
                                        isEditing = true
                                        
                                    },
                                    .destructive(Text("action.delete".i18n())) {
                                        // Show the delete confirmation alert
                                        isDeleting = true
                                    },
                                    .cancel()
                                ])
                            }
                        },
                        alignment: .topTrailing
                    )
                } else {
                    Text("Image url not found")
                }
            }
            
            VStack(alignment: .leading) {
                Text(planDetail.destination.name ?? "")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryColor"))
                
                Text("\(planDetail.start.displayFormat) - \(planDetail.end.displayFormat)")
                    .font(.caption)
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(.top,2)
            }
        }
        .padding()
        // add a background of white color with rounded corners and shadow
        .background(Rectangle()
            .foregroundColor(.white)
            .cornerRadius(20)
            .shadow(radius: 15))
        .padding()
    }
}

struct OnGoingTripView_Previews: PreviewProvider {
    static var previews: some View {
        OnGoingTripView()
    }
}

/* An extension to create a custom date format */
extension Date{
    var displayFormat:String {
        self.formatted(
            .dateTime
                .year(.defaultDigits)
                .month(.wide)
                .day()
        )
    }
    
}
