//
//  CampsiteDetailView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI
import MapKit

struct CampsiteDetailView: View {
    //PROPERTIES
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var moc
    let provider = PersistenceController.shared
    
    @ObservedObject var campsite: CampingSite
        
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        NavigationView {
            VStack(){
                // Campsite Image
                ZStack(alignment: .top){
                    
                    AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .frame(height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    VStack(spacing: 0.0){
                        HStack {
                            
                            // Button to go back previous page
                            Button{
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                            Spacer()
                            
                            // Button to add or remove campsite from favorite
                            Button{
                                campsite.isFavorite.toggle()
                            } label: {
                                Image(systemName: "heart.fill")
                                    .font(.title)
                                    .foregroundColor(campsite.isFavorite ? .red : .white)
                                    .padding()
                                
                            }
                        }
                        .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
                    }
                }
                .background(Color.clear)
                
                // Campsite detail
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text(campsite.name ?? "Not available")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                    
                        HStack{
                            if let weather = weather {
                                WeatherConditionView(weather: weather)
                            }else {
                                ProgressView()
                                    .task{
                                        do{
                                            weather = try await weatherManager.getCurrentWeather(latitude: campsite.latitude, longtitude: campsite.longitude)
                                        }catch{
                                            print("Error getting weather condition: \(error)")
                                        }
                                    }
                            }
                        }
                        .padding()
                        HStack {
                            
                            Spacer()
                            
                            VStack(alignment: .center, spacing: 5){
                                Text("Campfire area")
                                    .font(.headline)
                                if campsite.hasCampfireSite == true {
                                    Text("Available")
                                        .font(.subheadline)
                                }else {
                                    Text("Not available")
                                        .font(.subheadline)
                                }
                            }

                            
                            Spacer()
                            VStack(alignment: .center, spacing: 5){
                                Text("Rental Hut")
                                    .font(.headline)
                                if campsite.hasRentalHut == true {
                                    Text("Available")
                                        .font(.subheadline)
                                }else {
                                    Text("Not Available")
                                        .font(.subheadline)
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Text("Description")
                            .font(.headline)
                            .padding()
                        Text(campsite.descriptionEN ?? "nil")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        Text("Accessibilty")
                            .font(.headline)
                            .padding()
                        Text(campsite.suitabilityEN ?? "")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.primary)
                            .padding(.horizontal)
                        
                        HStack{
                            
                            NavigationLink{
                                CampsiteMapView(campsite: campsite)
                            } label: {
                                ViewOnMapButtonView()
                            }
                            
                            NavigationLink{
                                Text("Add campsite to add plan as default destination")
                            } label: {
                                PlanNewTripButtonView()
                            }
                            
                            
                        }
                        .padding()
                    }
                    .padding()
                }
                
            }
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

