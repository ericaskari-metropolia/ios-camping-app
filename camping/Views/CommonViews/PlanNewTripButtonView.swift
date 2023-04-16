//
//  PlanNewTripButtonView.swift
//  camping
//
//  Created by Chi Nguyen on 15.4.2023.
//

import SwiftUI

struct PlanNewTripButtonView: View {
    var body: some View {
        Button(action: {}, label: {
            Spacer()
            Text("Plane new trip")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.white)
            Spacer()
        })
        .padding(15)
        .background(Color(.blue))
        .clipShape(Capsule())
    }
}

struct PlanNewTripButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlanNewTripButtonView()
    }
}