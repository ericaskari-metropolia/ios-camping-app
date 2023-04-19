//
//  SuggestCampsites.swift
//  camping
//
//  Created by Thu Hoang on 19.4.2023.
//

import SwiftUI

struct SuggestCampsitesView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @FetchRequest(entity: CampingSite.entity(), sortDescriptors:[]) var results: FetchedResults<CampingSite>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center, spacing: 20){
                ForEach(homeViewModel.suggestCampsites, id: \.self){campingSite in
                    NavigationLink(destination: CampsiteDetailView(campsite: campingSite)){
                        SuggestCampsitesListItemView(campingSite: campingSite)
                    }
                }
            }
            .frame(height: 170)
            .padding(.vertical, 10)
        }
        .onAppear{
            homeViewModel.suggestCampsiteBasedOnDistance(campingSites: results)
        }

    }
}

//struct SuggestCampsitesView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuggestCampsitesView()
//    }
//}
