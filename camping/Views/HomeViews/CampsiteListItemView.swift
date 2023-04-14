//
//  CampsiteListItemView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI

struct CampsiteListItemView: View {
    
    // PROPERTIES
//    @State var campsite: CampingSiteData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            AsyncImage(url: URL(string: "https://www.luontoon.fi/documents/10550/56970047/EtelaKonnevesi_lapinsalonluoto_talvi_JouniLehmonen_1050x590.jpg/bdad1cd7-c84b-516f-470f-b27ddd46aef6?t=1539077864166")) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 350, height: 200)
            HStack(alignment: .top, spacing: 200) {
                Text("Hello world")
                    .font(.title2)
                .foregroundColor(.primary)
                
                Label("", systemImage: "map.circle")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 30))
                
            }
            
        }
    }
}

struct CampsiteListItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        CampsiteListItemView()
    }
}
