//
//  CategoryListView.swift
//  camping
//
//  Created by Chi Nguyen on 10.4.2023.
//

import SwiftUI

// MARK: - CAMPSITE LIST BASED ON CATEGORY

struct CampsiteListView: View {
    
    // PROPERTIES
    @State var category: Category
    
    // Fetch campsites
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    
    // BODY
    var body: some View {
        VStack(){
            
            ZStack(alignment: .leading){
                Image(category.image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                
            }
            .background(Color.clear)
            .navigationTitle("\(category.title) campsites")
            .edgesIgnoringSafeArea(.top)
            
            ScrollView{
                ForEach(results, id: \.self) {campingSite in
                    if(campingSite.category == category.title){
                        NavigationLink(destination: CampsiteDetailView(campsite: campingSite)){
                            CampsiteListItemView(campsite: campingSite)
                        }
                    }
                }
            }
            
        }
        
        }
        
    }


struct CampsiteListView_Previews: PreviewProvider {
    static var previews: some View {
        CampsiteListView(category: categories[0])
    }
}
