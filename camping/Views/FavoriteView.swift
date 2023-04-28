//
//  Favorite.swift
//  camping
//
//  Created by The Minions on 3.4.2023.
//

import SwiftUI

// MARK: Display a list of all favorite campsites
struct FavoriteView: View {
    
    @Environment(\.managedObjectContext) private var moc
    let provider = PersistenceController.shared
    @EnvironmentObject var locationViewModel: LocationViewModel
    // Get the favorite campsites
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFavorite == %@", NSNumber(value: true))) var campsites: FetchedResults<CampingSite>
    
    var body: some View {
        VStack{
            HeaderView(title: "fav.title".i18n())
                .ignoresSafeArea()
                .padding(.bottom, -40)

            
            ScrollView{
                if campsites.count > 0{
                    ForEach(campsites, id: \.self){
                        campsite in
                        NavigationLink{
                            CampsiteDetailView(campsite: campsite)
                        } label :{
                            FavoriteItemView(campsite: campsite)
                        }
                    }
                } else {
                    Text ("You don't have any saved campsite yet!")
                }
            }            
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(LocationViewModel())
    }
}
