//
//  OnGoingTripView.swift
//  camping
//
//  Created by Binod Panta on 18.4.2023.
//

import SwiftUI

struct OnGoingTripView: View {
    
    @StateObject var viewModel = MyTripViewModel(context: PersistenceController.shared.container.viewContext)
    @State var upcomingPlans: [AddPlantFirstStepViewOutput] = []
    
    
    
    var body: some View {
        HStack{
            ScrollView{
            ForEach(viewModel.planDetails) { planDetail in
                                    VStack(alignment: .leading, spacing: 10) {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                            if let imageURLString = planDetail.imageURL, let imgURL = URL(string: imageURLString) {
                                AsyncImage(url: imgURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 350, height: 200)
                                        .frame(maxWidth: (UIScreen.main.bounds.width - 70))
                                        .cornerRadius(15)
                                } placeholder: {
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
                            Text(planDetail.destination.name!)
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("\(planDetail.start.displayFormat) - \(planDetail.end.displayFormat)")
                                                   .font(.caption)
                                                   .foregroundColor(.secondary)
                                               
                        }
                    }
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 15))
                    .padding()
                }
                .onAppear {
                    viewModel.planDetails = viewModel.fetchAllPlans()
                    viewModel.campingSites = viewModel.fetchAllCampingSites()
                }
            }
        }
        
    }
}
struct OnGoingTripView_Previews: PreviewProvider {
    static var previews: some View {
        OnGoingTripView()
    }
}

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
