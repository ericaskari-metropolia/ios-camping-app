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
    
    // Fetch user
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    
    @State var list: Array<CampingSite> = []
    func getList() {
        self.list = results.filter{$0.category?.lowercased() == self.category.title.lowercased() }
        print(type(of: list[0]))
        }
    
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
                ForEach(list, id: \.self) {campingSite in
                    NavigationLink(destination: CampsiteDetailView()){
                        CampsiteListItemView()
        
                    }
                }
            }
            
        }
        .onAppear(perform: {getList()})
        
            
        }
        
    }


struct CampsiteListView_Previews: PreviewProvider {
    static var previews: some View {
        CampsiteListView(category: categories[0])
    }
}
