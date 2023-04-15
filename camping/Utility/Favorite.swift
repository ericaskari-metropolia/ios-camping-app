//
//  Favorite.swift
//  camping
//
//  Created by Chi Nguyen on 15.4.2023.
//

import Foundation


class Favorite: ObservableObject {
    @Published var favorite: Bool = false
    @Published var selectedCampsite: CampingSite? = nil
}
 
