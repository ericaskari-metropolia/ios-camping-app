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
                CityListItemView(cityName: campingSite.name!)
                //                    .background(
                //                        NavigationLink {
                //                            CampingSitesFilteredByCityListView()
                //                        } label: {
                //                            EmptyView()
                //                        }
                //                        .opacity(0)
                //                        .background(.clear)
                //                    )
                //                    .listRowBackground(Color.clear)
                //            }
                    .listRowSeparator(.hidden)
                    .listStyle(PlainListStyle())
            }
            .scrollContentBackground(.hidden)
        }
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
