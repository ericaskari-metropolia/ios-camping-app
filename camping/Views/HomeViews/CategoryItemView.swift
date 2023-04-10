//
//  CategoryCardView.swift
//  camping
//
//  Created by Chi Nguyen on 10.4.2023.
//

import SwiftUI


struct CategoryItemView: View {
    // PROPERTY
    let category: Category
    // BODY
    var body: some View {
        ZStack {
            VStack{
                // CATEGORY: IMAGE
                Image(category.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250,height: 200, alignment: .center)
            }
            .frame(width: 250,height: 200, alignment: .center)
            // CATEGORY: TITLE
            Text(category.title)
                .foregroundColor(.white)
                .font(.system(.title3))
                .fontWeight(.bold)
                .offset(y: 50)
                
        }
    }
}

// PREVIEW
struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: categories[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
