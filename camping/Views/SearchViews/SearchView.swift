//
//  SearchView.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//

import Foundation
import SwiftUI
import AVFoundation

// Search View

struct SearchView: View {
    @Environment(\.dismiss) var dismiss

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
            
            // If there is no city available
            if (searchViewModel.filteredCities.isEmpty) {
                VStack{
                    Text("Oops, no available city! Please enter another city!")
                        .foregroundColor(.white)
                    Image("search-empty")
                        .resizable()
                        .frame(maxWidth: 400, maxHeight: 250)
                        .padding()
                }
                .frame(maxHeight: .infinity)
            } else {
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
            
        }
        .padding(.top, 18)
        .padding(.horizontal, 18)
        .background(LinearGradient(gradient: Gradient(colors: [Color("PrimaryColor"), .white]), startPoint: .top, endPoint: .bottom))
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    .font(.title)
                    .padding()
                }
                .symbolVariant(.circle.fill)
                .foregroundStyle(Color("PrimaryColor"), .white)
        )
    }
}
