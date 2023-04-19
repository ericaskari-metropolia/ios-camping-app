//
//  SuggestCampsitesListItemView.swift
//  camping
//
//  Created by Thu Hoang on 19.4.2023.
//

import SwiftUI

// View for each item in the suggest camping sites based on user's location

struct SuggestCampsitesListItemView: View {
    let campingSite: CampingSite
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: (campingSite.imageURL ?? "header"))) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
            }
            Text(campingSite.name ?? "" + "\n")
                .lineLimit(2)
        }
        .frame(width: 200, height: 150)
    }
}

//struct SuggestCampsitesListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuggestCampsitesListItemView()
//    }
//}
