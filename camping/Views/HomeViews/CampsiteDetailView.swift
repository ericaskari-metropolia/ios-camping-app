//
//  CampsiteDetailView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI

struct CampsiteDetailView: View {
    
    //PROPERTIES
   @State var campsite: CampingSite
    
    var body: some View {
        VStack(){
            // Image
            ZStack(alignment: .leading){
                
                AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
                }
                
//                Image(campsite.imageURL)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 300)
                
            }
            .background(Color.clear)
            .navigationTitle(campsite.name ?? "nil")
            .edgesIgnoringSafeArea(.top)
            
            // Text
            ScrollView {
                ZStack() {
                    Text(campsite.name ?? "")
                        .font(.title)
                        .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    
                    HStack{
                        Label("", systemImage: "mappin.and.ellipse")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                        Text("Espoo")
                            .foregroundColor(.primary).bold()
                    }
                    .offset(x: 40, y: 30)
                    
                }
                VStack{
                    Label("", systemImage: "mappin.and.ellipse")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                    Text("Rain")
                        .foregroundColor(.primary).bold()
                }
                
                Text(campsite.descriptionEN ?? "nil")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                
                
            }
            
        }
    }
}

//struct CampsiteDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CampsiteDetailView()
//    }
//}
