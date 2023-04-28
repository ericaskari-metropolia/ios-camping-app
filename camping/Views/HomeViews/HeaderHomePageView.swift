//
//  HeaderHomePageView.swift
//  camping
//
//  Created by Thu Hoang on 14.4.2023.
//

import Foundation
import SwiftUI

// View for Header homepage

struct HeaderHomePageView: View {
    
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
            .offset(x: 40, y: 30)
            
            Text("homepage.title".i18n())
                .bold()
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 40, y: 60)
            
            Button(action: {
                self.isSearchFieldButtonPressed = true
            }){
                HStack{
                    Label("", systemImage: "magnifyingglass")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 20))
                    Text("homepage.search".i18n()).foregroundColor(.gray)
                    Label("", systemImage: "mic")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 20))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 1.5)
                )
            }
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(20)
            .offset(x: UIScreen.main.bounds.width/5, y: 150)
        }
        .padding(.bottom, 20)
        .background(Color.clear)
        
        NavigationLink(destination: SearchView(), isActive: $isSearchFieldButtonPressed) {
            EmptyView()
        }
        
    }
}

struct HeaderHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderHomePageView().environmentObject(LocationViewModel())
    }
}
