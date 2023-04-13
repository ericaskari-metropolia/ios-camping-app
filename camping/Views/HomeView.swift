//
//  Home.swift
//  camping
//
//  Created by Chi Nguyen on 3.4.2023.
//

import SwiftUI
import MapKit
import CoreData

struct HomeView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    
    var body: some View {
        VStack(){
            ZStack(alignment: .leading){
                Image("header")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                
                HStack{
                    Label("", systemImage: "location")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Text("You are in \(locationViewModel.currentPlacemark?.locality ?? "")")
                        .foregroundColor(.white).bold()
                }
                .offset(x: 40, y: 30)
                
                Text("Discovery")
                    .bold()
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: 40, y: 60)
                
                Button(action: {}){
                    HStack{
                        Label("", systemImage: "magnifyingglass")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 20))
                        Text("Where do you want to go?").foregroundColor(.gray)
                        Label("", systemImage: "mic")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 20))
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1.5)
                    )
                }
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(20)
                .offset(x: UIScreen.main.bounds.width/5, y: 150)
            }
            .padding(.bottom, 20)
            .background(Color.clear)
            
            ScrollView{
                CampCategoryView().padding(.horizontal, 5)
                HStack{
                    Text("Latitude:")
                    Text("\(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0)")
                }
                
                HStack{
                    Text("Longitude:")
                    Text("\(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)")
                }
                
                HStack{
                    Text("City:")
                    Text(locationViewModel.currentPlacemark?.locality ?? "")
                }
                
                HStack{
                    Text("campsite:")
                    Text("\(results.count)")
                }
                
                ForEach(results, id: \.self) { campingSite in
                    HStack{
                        Text("Camping site:")
                        Text(campingSite.name ?? "")
                    }
                }
            }
        }
        .onAppear {
            locationViewModel.fetchCampingSites()
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(LocationViewModel())
    }
}
