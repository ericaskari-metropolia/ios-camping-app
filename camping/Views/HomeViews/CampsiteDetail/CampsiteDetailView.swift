//
//  CampsiteDetailView.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//


import SwiftUI
import MapKit

// MARK: Display all information related to chosen campsite
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
                                Image(systemName: "chevron.left")
                                    .font(.title)
                                    .padding()
                                
                            }
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(Color("PrimaryColor"), .white)
                            
                            Spacer()
                            
                            // Button to add or remove campsite from favorite
                            Button{
                                campsite.isFavorite.toggle()
                            } label: {
                                Image(systemName: "heart.square")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(campsite.isFavorite ? .red : .white)
                                    .background(Color("PrimaryColor"))
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
                                Text("detail.campfire".i18n())
                                    .font(.headline)
                                if campsite.hasCampfireSite == true {
                                    Text("detail.available".i18n())
                                        .font(.subheadline)
                                }else {
                                    Text("detail.notAvailable".i18n())
                                        .font(.subheadline)
                                }
                            }
                            
                            Spacer()
                            VStack(alignment: .center, spacing: 5){
                                Text("detail.rental".i18n())
                                    .font(.headline)
                                if campsite.hasRentalHut == true {
                                    Text("detail.available".i18n())
                                        .font(.subheadline)
                                }else {
                                    Text("detail.notAvailable".i18n())
                                        .font(.subheadline)
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Text("detail.description".i18n())
                            .font(.headline)
                            .padding(.horizontal)
                        Text(campsite.descriptionEN ?? "nil")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        Text("detail.accessibility".i18n())
                            .font(.headline)
                            .padding(.horizontal)
                        Text(campsite.suitabilityEN ?? "")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.primary)
                            .padding(.horizontal)
                        
                        Text("detail.website".i18n())
                            .font(.headline)
                            .padding(.horizontal)
                        Link(destination: URL(string: "\(campsite.websiteURL ?? "")")!, label: {
                            Text(campsite.websiteURL ?? "")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(.systemBlue))
                                .padding(.horizontal)
                        })
                        
                        // Link to map view and add plan
                        HStack{
                            
                            NavigationLink{
                                CampsiteMapView(campsite: campsite)
                            } label: {
                                ViewOnMapButtonView()
                            }
                            
                            PlanNewTripButtonView(campsite: campsite) {
                                Text("detail.plan".i18n())
                                    .font(.system(.title3, design: .rounded))
                                    .foregroundColor(.white)
                            } completed: {
                                // Nothing to do
                            }
                            .padding(15)
                            .background(Color("PrimaryColor"))
                            .clipShape(Capsule())
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





