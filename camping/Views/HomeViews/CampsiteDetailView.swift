//
//  CampsiteDetailView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI

struct CampsiteDetailView: View {
    
    //PROPERTIES
   @State var campsite: CampingSite
    
    var body: some View {
        VStack(){
            // Campsite Image
            ZStack(alignment: .leading){
                
                AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
                }
                
                Button(action: {}, label: {
                    Image(systemName: "heart")
                        .font(.title)
                        .foregroundColor(.white)
                })
                .offset(x: 350, y: -75)
                
                
            }
            .background(Color.clear)
            .edgesIgnoringSafeArea(.top)
            
            // Campsite detail
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Text(campsite.name ?? "Not available")
                        .font(.title)
                        .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    
                    HStack {
                        HStack{
                            Label("", systemImage: "mappin.and.ellipse")
                                .labelStyle(.iconOnly)
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text(campsite.region ?? "Not available")
                                .foregroundColor(.primary).bold()
                        }
                        HStack{
                            Label("", systemImage: "mappin.and.ellipse")
                                .labelStyle(.iconOnly)
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text("Weather condition")
                                .foregroundColor(.primary).bold()
                        }
                    }
                    
                    Text(campsite.descriptionEN ?? "nil")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    // Buttons
                    HStack{
                        ViewOnMapButtonView()
                        PlanNewTripButtonView()
                    }
                    .padding()
                }
                
            }
            
        }
    }
}

//struct CampsiteDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CampsiteDetailView()
//    }
//}
