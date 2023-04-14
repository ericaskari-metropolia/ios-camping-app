//
//  CityListItem.swift
//  camping
//
//  Created by Thu Hoang on 14.4.2023.
//

import Foundation
import SwiftUI

struct CityListItemView: View {
    let cityName: String
    var body: some View{
        HStack(){
            Text("\(cityName)")
            Spacer()
            Label("", systemImage: "chevron.right")
                .labelStyle(.iconOnly)
        }
        .padding()
        .frame(width: 300)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth:1)
        )
    }
}

struct CityListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CityListItemView(cityName: "Helsinki")
    }
}
