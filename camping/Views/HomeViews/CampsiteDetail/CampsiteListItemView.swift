//
//  CampsiteListItemView.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//

import SwiftUI

// MARK: Display a list of campsites based on choosen category

struct CampsiteListItemView: View {
    
    //PROPERTIES
    @State var campsite: CampingSite
    
    var body: some View {
        
        HStack(spacing: spacing){
            AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            } placeholder: {
                ProgressView()
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10){
                Text(campsite.name ?? "")
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.primary)
                Text(campsite.region ?? "")
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
        }
        
    }
}
