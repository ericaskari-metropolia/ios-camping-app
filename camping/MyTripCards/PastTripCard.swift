//
//  PastTripCard.swift
//  camping
//
//  Created by Binod Panta on 11.4.2023.
//

import SwiftUI

struct PastTripCard: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            ZStack{
                Image("promo6")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200,height: 120)
                    .frame(maxWidth: (UIScreen.main.bounds.width - 100) / 2)
                    .cornerRadius(15)
            }
            VStack{
                    Text("Kotka 2023")
                        .font(.headline)
                        .fontWeight(.black)
                    
                    Text("3 months ago")
                        .foregroundColor(.blue)
                        .font(.caption)
                        .padding(.leading,-20)
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

struct PastTripCard_Previews: PreviewProvider {
    static var previews: some View {
        PastTripCard()
    }
}
