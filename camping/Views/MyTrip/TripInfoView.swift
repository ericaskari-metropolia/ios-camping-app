//
//  TripInfoView.swift
//  camping
//
//  Created by The Minions on 19.4.2023.
//

/* A view that gives information about the planned ongoing trip,
 with weather, campsite, and gears info*/

import SwiftUI

struct TripInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // state variable to hold the plan detail
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
                        
                        HStack{
                            Text("label.tripOverview".i18n())
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 200, height: 40)
                        .background(Color("PrimaryColor").opacity(0.2).cornerRadius(10))
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 40, leading: -45, bottom: 0, trailing: 0))
                    
                }
                
            }
            .ignoresSafeArea()
            HStack{
                Label("label.onGoingTripStatus".i18n(), systemImage: "figure.run.circle")
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
                        Text(planDetail.destination.name ?? "label.destinationlocation".i18n())
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "tent")
                        .foregroundColor(Color("PrimaryColor"))
                        
                    }
                    .padding(.bottom, -15)
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
                    .padding(.top, -15)
                    .padding()
                    
                    HStack{
                        NavigationLink(destination: CampsiteMapView(campsite: planDetail.destination)){
                        Label("action.viewOnMap".i18n(), systemImage: "location")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 180, height: 40)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(15)
                    }
                    }
                    .padding(.top, -10)
                    .padding(.bottom,10)
                    
                }
                
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2))
                .padding(.top,10)
                .padding(.horizontal,3)
                
                VStack(alignment: .leading){
                    Text("label.weatherForecast".i18n())
                        .padding(.top,10)
                        .padding(.bottom, -5)
                        .padding(.leading,15)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    
                    if let weather = weather {
                        WeatherCardView(weatherForecast:weather, startTimestamp: Int(planDetail.start.timeIntervalSince1970))
                        
                    }else {
                        // if the weather data is not available, show a ProgressView and fetch the data asynchronously
                        ProgressView()
                            .task{
                                do{
                                    weather = try await weatherManager.getWeatherForecast(latitude: planDetail.destination.latitude, longitude: planDetail.destination.longitude)
                                }catch{
                                    print("Error getting weather condition: \(error)")
                                }
                            }
                    }
                }
                Divider()
                
                VStack(alignment: .leading){
                    Label("label.gearChecklist".i18n(), systemImage: "list.bullet")
                        .fontWeight(.bold)
                        .padding(.vertical,0)
                        .foregroundColor(Color("PrimaryColor"))
                    
                    // Text("Oops!! you dont have any gears added.")
                    MyGearListView(plan:planDetail.plan)
                    
                }
                .padding()
                Spacer()
            }
            .padding()
            .padding(.top,-55)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
    }
}
