//
//  CategoryCardView.swift
//  camping
//
//  Created by Chi Nguyen on 10.4.2023.
//

import SwiftUI

let category: Category

struct CategoryItemView: View {
    let categories: Category
    var body: some View {
        ZStack {
            VStack{
                // CATEGORY: IMAGE
                Image(categories.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, alignment: .center)
                
            }
            // CATEGORY: TITLE
            Text(categories.title)
                .foregroundColor(.white)
                .font(.system(.title3))
                .fontWeight(.bold)
                .offset(y: 50)
                
        }
        .cornerRadius(30)
        
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(category: category[0])
    }
}
