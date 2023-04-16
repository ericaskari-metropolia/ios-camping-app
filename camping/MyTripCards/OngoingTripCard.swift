//
//  OngoingTripCard.swift
//  camping
//
//  Created by Binod Panta on 11.4.2023.
//

/* This is a card view for ongoing trips  */

//Logic not implemented yet, Mostly hardcoded values.

import SwiftUI

struct OngoingTripCard: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            ZStack(alignment:Alignment(horizontal: .trailing, vertical: .top)){
                Image("promo6")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350,height: 200)
                    .frame(maxWidth: (UIScreen.main.bounds.width - 70))
                    .cornerRadius(15)
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 24))                    .padding()
            }
            VStack(alignment: .leading) {
                    Text("Kotka 2023")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("16 April 2023 - 28 April 2023")
                        .foregroundColor(.blue)
                }
        }
        .padding()
        .background(Rectangle()
            .foregroundColor(.white)
            .cornerRadius(20)
            .shadow(radius: 15))
        .padding()
    }
}

struct OngoingTripCard_Previews: PreviewProvider {
    static var previews: some View {
        OngoingTripCard()
    }
}
