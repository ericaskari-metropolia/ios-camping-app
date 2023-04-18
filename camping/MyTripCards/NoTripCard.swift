//
//  NoTripCard.swift
//  camping
//
//  Created by Binod Panta on 17.4.2023.
//

import SwiftUI

struct NoTripCard: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            ZStack(alignment:Alignment(horizontal: .trailing, vertical: .top)){
                Image("no-plan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 380,height: 240)
                    .frame(maxWidth: (UIScreen.main.bounds.width - 70))
                    .cornerRadius(15)

            }
            VStack(alignment: .leading) {
                    Text("OOPS!!")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("You do not have any ongoing plans")
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

struct NoTripCard_Previews: PreviewProvider {
    static var previews: some View {
        NoTripCard()
    }
}
