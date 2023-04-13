//
//  CategoryListView.swift
//  camping
//
//  Created by Chi Nguyen on 14.4.2023.
//

import SwiftUI

// MARK: Display a list of category of campsites

struct CategoryListView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center, spacing: 20){
                ForEach(categories){category in
                    NavigationLink(destination: CampsiteListView(category: category)){
                        CategoryListItemView(category: category)
                    }
                }
            }
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
