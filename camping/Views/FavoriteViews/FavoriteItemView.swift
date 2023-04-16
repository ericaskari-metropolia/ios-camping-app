//
//  FavoriteItemView.swift
//  camping
//
//  Created by Chi Nguyen on 16.4.2023.
//

import SwiftUI

struct FavoriteItemView: View {
    
    @EnvironmentObject var favoriteManager: FavoriteManager
    var campsite: CampingSite
    
    var body: some View {
        HStack(spacing: spacing){
            AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text(campsite.name ?? "")
                        .bold()
                Text(campsite.region ?? "")
            }
                
            Spacer()
                
            Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.title)
                    .onTapGesture{
                        favoriteManager.removeFromFavorite(campsite: campsite)
                    }
            
            }
            .padding(.horizontal)

        }
    }

    

//struct FavoriteItemView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FavoriteItemView()
//    }
//}
