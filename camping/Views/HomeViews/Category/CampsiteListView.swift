//
//  CategoryListView.swift
//  camping
//
//  Created by Chi Nguyen on 10.4.2023.
//

import SwiftUI

// MARK: - CAMPSITE LIST BASED ON CATEGORY

struct CampsiteListView: View {
    @Environment(\.dismiss) var dismiss
    
    // PROPERTIES
    @State var category: Category
    
    @FetchRequest(fetchRequest: CampingSite.all()) private var campsites
    
    // Filter list
    @State var list: [CampingSite] = []
    
    func filterList(){
        self.list = campsites.filter{$0.category?.lowercased() == category.title.lowercased()}
    }
    
    // BODY
    var body: some View {
        VStack(){
            
            ZStack(alignment: .top){
                Image(category.image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                
                VStack(spacing: 0.0){
                    HStack {
                        
                        // Button to go back previous page
                        Button{
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Text("\(category.title) campsites")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                        
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 50, leading: 40, bottom: 0, trailing: 40))
                }
                
            }
            .background(Color.clear)
            
            
            ScrollView{
                ForEach(list, id: \.self) {campingSite in
                    NavigationLink(destination: {
                        CampsiteDetailView(campsite: campingSite)
                    }, label: {
                        CampsiteListItemView(campsite: campingSite)
                    })
                    .navigationBarHidden(true)
                }
            }
            
        }
        .onAppear(perform: {filterList()})
        .edgesIgnoringSafeArea(.top)
        
        }
        
    }


struct CampsiteListView_Previews: PreviewProvider {
    static var previews: some View {
        CampsiteListView(category: categories[0])
    }
}
