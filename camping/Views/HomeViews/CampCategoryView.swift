//
//  CategoriesView.swift
//  camping
//
//  Created by Chi Nguyen on 10.4.2023.
//

import SwiftUI

struct CampCategoryView: View {
    
    let campCategories = categories
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CampCategoryView()
    }
}
