//
//  ViewOnMapView.swift
//  camping
//
//  Created by The Minions on 15.4.2023.
//

import SwiftUI

struct ViewOnMapButtonView: View {
    var body: some View {
        HStack{
            Spacer()
            Text("detail.view".i18n())
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(15)
        .background(Color("PrimaryColor"))
        .clipShape(Capsule())
    }
}

struct ViewOnMapButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ViewOnMapButtonView()
    }
}
