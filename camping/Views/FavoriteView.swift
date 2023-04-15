//
//  Favorite.swift
//  camping
//
//  Created by Chi Nguyen on 3.4.2023.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var favorite: Favorite
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack{
            ZStack{
                HeaderView()
                Text("Saved locations")
                    .bold()
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: -75, y: 60)
            }
            .edgesIgnoringSafeArea(.top)
            ScrollView{
                
            }
            
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(LocationViewModel())
            .environmentObject(Favorite())
    }
}
