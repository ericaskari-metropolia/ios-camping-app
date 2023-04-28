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
            Text("View on map")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(15)
        .background(Color.primary)
        .clipShape(Capsule())
    }
}

struct ViewOnMapButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ViewOnMapButtonView()
    }
}
