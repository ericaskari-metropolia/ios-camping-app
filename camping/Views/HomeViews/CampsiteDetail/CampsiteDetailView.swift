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
            VStack(){
                // Campsite Image
                AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
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
                            .padding(.horizontal)
                        Text(campsite.descriptionEN ?? "nil")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        Text("Accessibilty")
                            .font(.headline)
                            .padding(.horizontal)
                        Text(campsite.suitabilityEN ?? "")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.primary)
                            .padding(.horizontal)
                        
                        Text("Website")
                            .font(.headline)
                            .padding(.horizontal)
                        Link(destination: URL(string: "\(campsite.websiteURL ?? "")")!, label: {
                            Text(campsite.websiteURL ?? "")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(.systemBlue))
                                .padding(.horizontal)
                        })
                        
                        
                        HStack{
                            
                            NavigationLink{
                                CampsiteMapView(campsite: campsite)
                            } label: {
                                ViewOnMapButtonView()
                            }
                            
                            NavigationLink{
                                Text("Add campsite to add plan as default destination")
                            } label: {
                                PlanNewTripButtonView(campsite: campsite) {
                                    //  Nothing todo
                                }
                            }
                            
                            
                        }
                        .padding()
                    }
                    .padding()
                }
                
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        campsite.isFavorite.toggle()
                    } label: {
                        Image(systemName: campsite.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(campsite.isFavorite ? .red : .black)
                    }
                }
            }
    }
    
}

