//
//  CategoryListView.swift
//  camping
//
//  Created by Chi Nguyen on 10.4.2023.
//

import SwiftUI

// MARK: - CAMPSITE LIST BASED ON CATEGORY

struct CategoryListView: View {
    
    @State var category: Category
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading, spacing: 25){
                //IMAGE
                Image(category.image)
                    .resizable()
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: .infinity, height: .infinity, alignment: .top)
                    .edgesIgnoringSafeArea(.all)
                    
            }
            //Title
            .navigationTitle(category.title)
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(category: categories[0])
    }
}
