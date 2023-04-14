//
//  SearchView.swift
//  camping
//
//  Created by Thu Hoang on 14.4.2023.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel(searchText: "")
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    
    var body: some View {
        VStack{
            HStack{
                Label("", systemImage: "magnifyingglass")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 20))
                
                TextField(
                    "Enter a city",
                    text:
                            .init(get: {
                                searchViewModel.searchText
                            }, set: { value in
                                searchViewModel.searchTextUpdated(value: value)
                            })
                )
                
                Label("", systemImage: "mic")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 20))
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1.5)
            )
            .padding(.horizontal, 18)
            
            
            List {
                ForEach(searchViewModel.filteredCities, id: \.self) { city in
                    CityListItemView(cityName: city)
                        .background(
                            NavigationLink {
                                CampingSitesFilteredByCityListView(cityString: city)
                            } label: {
                                EmptyView()
                            }
                                .opacity(0)
                                .background(.clear)
                        )
                        .listRowBackground(Color.clear)
                }
                .listRowSeparator(.hidden)
                .listStyle(PlainListStyle())
            }
            .scrollContentBackground(.hidden)
        }
        .padding(.top, 18)
        .onAppear {
            searchViewModel.filterFetchedCity(cities: results)
        }
    }
}


//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(value: )
//    }
//}
