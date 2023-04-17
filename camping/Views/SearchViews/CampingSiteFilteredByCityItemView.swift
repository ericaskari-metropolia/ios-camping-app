//
//  CampingSiteFilteredByCityItemView.swift
//  camping
//
//  Created by Thu Hoang on 17.4.2023.
//

import Foundation
import SwiftUI

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
                Text(campingSiteFiltered.category ?? "")
            }
            .padding( 16)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .cornerRadius(10)
    }
}

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

