//
//  FavoriteManager.swift
//  camping
//
//  Created by Chi Nguyen on 16.4.2023.
//

import Foundation

class FavoriteManager: ObservableObject{
    @Published var favoriteCampsites = [CampingSite]()
    
    func addToFavorite(campsite: CampingSite){
        favoriteCampsites.append(campsite)
    }
    
    func removeFromFavorite(campsite: CampingSite){
        if let index = favoriteCampsites.firstIndex(of: campsite){
            favoriteCampsites.remove(at: index)
        }
    }
    
}
