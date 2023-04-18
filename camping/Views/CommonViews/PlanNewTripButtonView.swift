//
//  PlanNewTripButtonView.swift
//  camping
//
//  Created by Chi Nguyen on 15.4.2023.
//

import SwiftUI

struct PlanNewTripButtonView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Plan new trip")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(15)
        .background(Color.primary)
        .clipShape(Capsule())
    }
}

struct PlanNewTripButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlanNewTripButtonView()
    }
}
