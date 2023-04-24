//
//  TripInfoView.swift
//  camping
//
//  Created by Binod Panta on 19.4.2023.
//
import SwiftUI

struct TripInfoView: View {
    
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
                    Text("Trip information")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,55)
                    
                }
            
            }
            .ignoresSafeArea()
            HStack{
                Label("Trip Status: Ongoing", systemImage: "figure.run.circle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 40)
                    .background(Color.cyan)
                    .cornerRadius(15)
                
            }
            .padding(.top,-80)
           
            ScrollView(.vertical,showsIndicators: false) {
                VStack{
                    HStack{
                        Text(planDetail.destination.name ?? "")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "tent")
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
                
                VStack(alignment: .leading){
                    Text("Weather Forecast")
                        .padding(.top,10)
                        .padding(.bottom, -5)
                        .padding(.leading,15)
                        .multilineTextAlignment(.leading)
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
                    Label("Gear List", systemImage: "list.bullet")
                        .padding(.vertical,0)
                  
                   // Text("Oops!! you dont have any gears added.")
                    MyGearListView(plan:planDetail.plan)
                    
                    NavigationLink(
                        destination: AddPlanGears(plan: planDetail.plan)
                            .environmentObject(GearViewModel()),
                        label: {
                            Text("Edit gear")
                                .frame(maxWidth: .infinity)
                        }
                    )
                    .padding()
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(30)
                }
                .padding()
                Spacer()
//                Label("Add Gear", systemImage: "plus")
//                    .foregroundColor(.white)
//                    .frame(width: 350, height: 50)
//                    .background(Color.black)
//                    .cornerRadius(15)
            }
            .padding()
            .padding(.top,-65)
            .ignoresSafeArea()
        }
    }
    
}

//struct TripInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripInfoView()
//    }
//}
