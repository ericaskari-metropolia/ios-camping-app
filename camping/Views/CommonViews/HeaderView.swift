//
//  HeaderView.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//

import SwiftUI

//MARK: top header to use in all view needed
struct HeaderView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    var title: String
        
    var body: some View {
        
        ZStack(alignment: .leading){
            Image("header")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 300)
            
            HStack{
                Label("", systemImage: "mappin.and.ellipse")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Text("You are in \(locationViewModel.currentPlacemark?.locality ?? "")")
                    .foregroundColor(.white).bold()
            }
            .offset(x: 40, y: 40)
            Text("\(title)")
                .bold()
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 40, y: 70)
        }
        .background(Color.clear)
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Discovery").environmentObject(LocationViewModel())
    }
}
