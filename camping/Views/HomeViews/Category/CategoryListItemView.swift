//
//  CategoryListItemView.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//

import SwiftUI

struct CategoryListItemView: View {
    // MARK: PROPERTIES
    let category: Category
    
    // MARK: BODY
    
    var body: some View {
        ZStack(){
            Image(category.image)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 150)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            Text(category.title)
                .foregroundColor(.white)
                .font(.title2)
                .offset(y:50)
        }
    }
}

struct CategoryListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListItemView(category: categories[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
