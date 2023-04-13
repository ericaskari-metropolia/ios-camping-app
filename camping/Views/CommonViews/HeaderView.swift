//
//  HeaderView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel

    
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
            
            Text("Discovery")
                .bold()
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 40, y: 60)
            
            Button(action: {}){
                HStack{
                    Label("", systemImage: "magnifyingglass")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 20))
                    Text("Where do you want to go?").foregroundColor(.gray)
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
        .background(Color.clear)    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView().environmentObject(LocationViewModel())
    }
}
