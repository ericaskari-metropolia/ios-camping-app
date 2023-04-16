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
    
    @EnvironmentObject var favoriteManger : FavoriteManager
    
    var body: some View {
        VStack(){
            // Campsite Image
            ZStack(alignment: .bottomLeading){
                
                AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
                }
                
                // Button to add or remove campsite from favorite
                Button{
                    if favoriteManger.favoriteCampsites.contains(campsite){
                        favoriteManger.removeFromFavorite(campsite: campsite)
                    }else{
                        favoriteManger.addToFavorite(campsite: campsite)
                    }
                    
                    print(favoriteManger.favoriteCampsites)
                } label: {
                    favoriteManger.favoriteCampsites.contains(campsite) ? (
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding()
                    ) : (
                        Image(systemName: "heart")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    )
                    
                }
                
            }
            .background(Color.clear)
            
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
                        .padding()
                        
                        Spacer()
                        
                        HStack{
                            Label("", systemImage: "mappin.and.ellipse")
                                .labelStyle(.iconOnly)
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text("Weather condition")
                                .foregroundColor(.primary).bold()
                        }
                        .padding()
                    }
                    
                    Text(campsite.descriptionEN ?? "nil")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.primary)
                        .padding(.horizontal)
                    
                    HStack{
                        ViewOnMapButtonView()
                        PlanNewTripButtonView()
                    }
                    .padding()
                }
                
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        
    }
    
}

//struct CampsiteDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CampsiteDetailView(campsite: campsite)
//    }
//}
