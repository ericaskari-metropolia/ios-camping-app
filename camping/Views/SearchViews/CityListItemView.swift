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
            Image(systemName: "mappin.and.ellipse")
            Text("\(cityName)")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CityListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CityListItemView(cityName: "Helsinki")
    }
}
