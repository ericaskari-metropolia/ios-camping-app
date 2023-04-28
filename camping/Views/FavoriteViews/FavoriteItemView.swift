//
//  FavoriteItemView.swift
//  camping
//
//  Created by The Minions on 16.4.2023.
//

import SwiftUI

struct FavoriteItemView: View {
    
    var campsite: CampingSite
    
    var body: some View {
        HStack(spacing: spacing){
            AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text(campsite.name ?? "")
                    .bold()
                    .multilineTextAlignment(.leading)
                Text(campsite.region ?? "")
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .font(.title)
                .onTapGesture{
                    campsite.isFavorite.toggle()
                }
        }
        .padding(.horizontal)
    }
}
