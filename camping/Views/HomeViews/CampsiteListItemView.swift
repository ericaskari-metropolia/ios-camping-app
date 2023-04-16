//
//  CampsiteListItemView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI

// MARK: Display a list of campsites based on choosen category

struct CampsiteListItemView: View {
    
     //PROPERTIES
    @State var campsite: CampingSite
    
    var body: some View {
        HStack(alignment: .top, spacing: 16){
            
            HStack {
                AsyncImage(url: URL(string: (campsite.imageURL) ?? "header")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 100, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 15))

                } placeholder: {
                    ProgressView()
            }
                Spacer()
            }
            .padding()
            
        
            VStack(alignment: .center, spacing: 8) {
                    Text(campsite.name ?? "nil")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                        Text(campsite.region ?? "nil")
                            .font(.footnote)
                        
                }
                
            Spacer()
                
                
            }
            
        }
    }


//struct CampsiteListItemView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        CampsiteListItemView(campsite: .constant(CampingSite()))
//    }
//}
