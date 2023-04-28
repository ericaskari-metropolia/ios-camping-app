//
//  PastTripInfoView.swift
//  camping
//
//  Created by The Minions on 20.4.2023.
//
import SwiftUI

struct PastTripInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var planDetail: PlanDetail
    
    // instance of weather forecast manager
    var weatherManager = WeatherForecast()
    
    // state variable to hold the forecast data
    @State var weather: Forecast?
    var body: some View {
        
        VStack{
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
                    HStack {
                        Spacer()
                        
                        // Button to go back previous page
                        Button{
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .padding()
                            
                        }
                        .symbolVariant(.circle.fill)
                        .foregroundStyle(Color("PrimaryColor"), .white)
                        
                        Spacer()
                        HStack{
                            Text("label.tripOverview".i18n())
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 200, height: 40)
                        .background(Color("PrimaryColor").opacity(0.2).cornerRadius(10))
                        Spacer()
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 40, leading: -30, bottom: 0, trailing: 0))
                    
                }
                
            }
            .ignoresSafeArea()
            HStack{
                Label("label.completedTripStatus".i18n(), systemImage: "trophy.circle.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 40)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(15)
                
            }
            .padding(.top,-80)
            
            ScrollView(.vertical,showsIndicators: false) {
                VStack{
                    HStack{
                        Text(planDetail.destination.name ?? "label.destinationlocation")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "tent")
                            .foregroundColor(Color("PrimaryColor"))

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
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Spacer()
                        Image(systemName: "note.text")
                            .foregroundColor(Color("PrimaryColor"))
                    }
                    .padding(.vertical, -15)
                    .padding()
                }
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2))
                .padding(.top,10)
                .padding(.horizontal,3)
                
                Divider()
                
                VStack(alignment: .leading){
                    Label("label.tripGearList".i18n(), systemImage: "list.bullet")
                        .fontWeight(.bold)
                        .padding(.vertical,0)
                        .foregroundColor(Color("PrimaryColor"))
                    PastGearListView(plan:planDetail.plan)
                    // Text("Oops!! Gear details not available.")
                }
                .padding()
                Spacer()
                PlanNewTripButtonView(campsite: planDetail.plan.campingSite) {
                    Label("btn.planAgain".i18n(), systemImage: "plus")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(15)
                } completed: {
                    
                }
                
            }
            .padding()
            .padding(.top,-65)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
    }
    
}
