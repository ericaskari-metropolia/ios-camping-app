//
//  CategoriesView.swift
//  camping
//
//  Created by Chi Nguyen on 10.4.2023.
//

import SwiftUI

// MARK: - CAMPSITE CATEGORIES VIEW

struct CampCategoryView: View {
        
    var body: some View {
        NavigationView{
            ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .center, spacing: columnSpacing){
                        ForEach(categories){category in
                            NavigationLink(destination: CategoryListView(category:category)){
                                CategoryItemView(category: category)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
        
        }
        .navigationBarTitle(Text("Categories"))
    }
}

struct CampCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CampCategoryView()
    }
}
