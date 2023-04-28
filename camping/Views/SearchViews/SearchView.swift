//
//  SearchView.swift
//  camping
//
//  Created by Thu Hoang on 14.4.2023.
//

import Foundation
import SwiftUI
import AVFoundation

// Search View

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel(searchText: "")
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    @State private var showingRecordingSheet = false
    
    
    
    var body: some View {
        VStack{
            // Search input field
            HStack{
                Label("", systemImage: "magnifyingglass")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 20))
                
                // Get search input as the user types to show the result city list in an autocomplete way
                TextField(
                    "search.bar".i18n(),
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
                    .onTapGesture{
                        showingRecordingSheet = true
                    }
            }
            .padding()
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 18)
            
            // City result list
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
        .sheet(
            isPresented: $showingRecordingSheet,
            onDismiss: {
                searchViewModel.searchTextUpdated(value: searchViewModel.searchText)
            },
            content: {
                RecordingSheetView(transcript: $searchViewModel.searchText)
                    .presentationDetents([.fraction(0.5)])
            })
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
