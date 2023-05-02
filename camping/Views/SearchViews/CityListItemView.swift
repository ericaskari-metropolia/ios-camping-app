//
//  CityListItem.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//

import Foundation
import SwiftUI

// View for each item in the city list result

struct CityListItemView: View {
    let cityName: String
    var body: some View{
        HStack(){
            Image(systemName: "mappin.and.ellipse")
            Text("\(cityName)")
                
                .bold()
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundColor(Color("PrimaryColor"))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CityListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CityListItemView(cityName: "Helsinki")
    }
}
