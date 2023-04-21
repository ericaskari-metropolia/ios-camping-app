//
//  OnGoingTripView.swift
//  camping
//
//  Created by Binod Panta on 18.4.2023.
//
/* A view that displays the ongoingtrip*/

import SwiftUI


struct OnGoingTripView: View {
    
    @StateObject var viewModel = MyTripViewModel(context: PersistenceController.shared.container.viewContext)
    
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
            HStack(spacing: 10) {
                
                //Looping through the array and create a tripdetail screen
                ForEach(planDetails) { planDetail in
                    NavigationLink(destination: {TripInfoView(planDetail:planDetail)}) {
                        OnGoingTripDetailScreen(planDetail: planDetail)
                        }
                       
                    
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct OnGoingTripDetailScreen: View {
    
    // A single plan detail object
    let planDetail: PlanDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {

                //convert string into URL if not nil
                if let imageURLString = planDetail.imageURL, let imgURL = URL(string: imageURLString) {
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
                        
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .padding()
                            .offset(x: 10, y: 10),
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
                
                Text("\(planDetail.start.displayFormat) - \(planDetail.end.displayFormat)")
                                .font(.caption)
                                .foregroundColor(.secondary)
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
