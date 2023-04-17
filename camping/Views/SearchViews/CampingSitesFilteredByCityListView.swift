//
//  CampingSitesFilteredByCityListView.swift
//  camping
//
//  Created by Thu Hoang on 14.4.2023.
//

import Foundation
import SwiftUI

struct CampingSitesFilteredByCityListView: View {
    let cityString: String
    @StateObject var searchViewModel = SearchViewModel(searchText: "")
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    
    var body: some View {
        List {
            ForEach(searchViewModel.filteredCampingSites, id: \.self) { campingSite in
                CampingSiteFilteredByCityItemView(campingSiteFiltered: campingSite)
                    .background(
                        NavigationLink {
                            CampsiteDetailView(campsite: campingSite)
                        } label: {
                            EmptyView()
                        }
                            .opacity(0)
                            .background(.clear)
                    )
                
            }
            .scrollContentBackground(.hidden)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(16)
        }
        .listStyle(GroupedListStyle())
        .background(Color(UIColor(red: 245/255, green: 246/255, blue: 245/255, alpha: 1.0)))
        .scrollContentBackground(.hidden)
        .onAppear{
            searchViewModel.filterCampingSiteCity(city: cityString, campingSites: results)
        }
    }
    
}

struct CampingSitesFilteredByCityListView_Previews: PreviewProvider {
    static var previews: some View {
        CampingSitesFilteredByCityListView(cityString: "Test")
    }
}
