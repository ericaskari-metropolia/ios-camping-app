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
            .background(.white)
            .cornerRadius(20)
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
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .background(.white)
            }
            .scrollContentBackground(.hidden)
        }
        .padding(.top, 18)
        .padding(.horizontal, 18)
        .background(Color(UIColor(red: 245/255, green: 246/255, blue: 245/255, alpha: 1.0)))
        .onAppear {
            searchViewModel.filterFetchedCity(cities: results)
        }
    }
}

extension Color {
    
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(value: )
//    }
//}
