//
//  PastTripInfoView.swift
//  camping
//
//  Created by Binod Panta on 20.4.2023.
//
import SwiftUI

struct PastTripInfoView: View {
    
    @State var planDetail: PlanDetail
    
    // instance of weather forecast manager
    var weatherManager = WeatherForecast()
    
    // state variable to hold the forecast data
    @State var weather: Forecast?
    var body: some View {
        
        VStack{
            pastTripHeader
                .ignoresSafeArea()
            pastTripStatusCard
            ScrollView(.vertical,showsIndicators: false) {
                pastPlanDetailCard
                Divider()
                gearListCard
                Spacer()
                planNewTripButton
            }
            .padding()
            .padding(.top,-65)
            .ignoresSafeArea()
        }
    }
}

extension PastTripInfoView {
    private var pastTripHeader: some View {
        ZStack(alignment: .top){
            if let imgURL = URL(string: planDetail.imageURL) {
                //create an AsyncImage with the URL
                AsyncImage(url: imgURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    // if the image is still loading, show a ProgressView
                    ProgressView()
                }
                
            }
            VStack{
                Text("Trip information")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top,55)
                
            }

        }
    }
    
    private var pastTripStatusCard: some View {
        HStack{
            Label("Trip Status: Completed", systemImage: "trophy.circle.fill")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 350, height: 40)
                .background(Color.cyan)
                .cornerRadius(15)
            
        }
        .padding(.top,-80)
    }
    
    private var pastPlanDetailCard: some View {
        VStack{
            HStack{
                Text(planDetail.destination.name ?? "")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "tent")
            }
            .padding(.bottom, -20)
            .padding()
            
            Divider()
                .padding(.vertical,5)
                .frame(height:1)
                .background(Color.black.opacity(0.1))
            
            HStack{
                Label("\(planDetail.start.displayFormat) - \(planDetail.end.displayFormat)", systemImage:"calendar")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                Image(systemName: "note.text")
            }
            .padding(.vertical, -15)
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2))
        .padding(.top,10)
        .padding(.horizontal,3)
    }
    
    private var gearListCard: some View {
        VStack(alignment: .leading){
            Label("Gear List", systemImage: "list.bullet")
                .padding(.vertical)
            PastGearListView(plan:planDetail.plan)
           // Text("Oops!! Gear details not available.")
        }
        .padding()
    }
    private var planNewTripButton:some View {
        PlanNewTripButtonView(campsite: planDetail.plan.campingSite) {
            Label("Plan Again", systemImage: "plus")
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color.black)
                .cornerRadius(15)
        } completed: {
            
        }
    }
}

//struct PastTripInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PastTripInfoView()
//    }
//}
