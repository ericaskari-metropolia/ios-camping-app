//
//  HeaderView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State private var isSearchFieldButtonPressed = false
    
    
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
            .offset(x: 40, y: 90)
        }
        .padding(.bottom, 20)
        .background(Color.clear)
        
        NavigationLink(destination: SearchView(), isActive: $isSearchFieldButtonPressed) {
            EmptyView()
        }
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView().environmentObject(LocationViewModel())
    }
}
