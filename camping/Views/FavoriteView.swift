//
//  Favorite.swift
//  camping
//
//  Created by Chi Nguyen on 3.4.2023.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var favoriteManager: FavoriteManager
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack{
            ZStack{
                HeaderView()
                Text("Saved locations")
                    .bold()
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: -75, y: 60)
            }
            
            ScrollView{
                if favoriteManager.favoriteCampsites.count > 0{
                    ForEach(favoriteManager.favoriteCampsites, id: \.self){
                        campsite in
                        NavigationLink{
                            CampsiteDetailView(campsite: campsite)
                        } label :{
                            FavoriteItemView(campsite: campsite)
                        }
                    }
                } else {
                    Text ("You don't have any saved campsite yet!")
                }
                
            }
            
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(LocationViewModel())
            .environmentObject(FavoriteManager())
    }
}
