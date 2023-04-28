//
//  CampingSiteFilteredByCityItemView.swift
//  camping
//
//  Created by The Minions on 17.4.2023.
//

import Foundation
import SwiftUI

// View for each camping site in the filter camping sites list that is in the same city

struct CampingSiteFilteredByCityItemView: View {
    let campingSiteFiltered: CampingSite
    var body: some View{
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: (campingSiteFiltered.imageURL ?? "header"))) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10, corners: [.topLeft,.topRight])
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(campingSiteFiltered.name ?? "")
                    .bold()
                    .foregroundColor(Color("PrimaryColor"))
                Text(campingSiteFiltered.address ?? "")
                    .foregroundColor(Color("PrimaryColor"))
            }
            .padding( 16)
        }
        .background(.white)
        .cornerRadius(10)
    }
}

// Custom corner radius to set specific which corner is round

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//struct CampingSiteFilteredByCityItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        CampingSiteFilteredByCityItemView()
//    }
//}

