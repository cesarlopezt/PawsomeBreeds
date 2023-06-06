//
//  FavoritesListView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var favoritesStorage: FavoritesStorage

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(favoritesStorage.breeds).sorted(by: { $0.breedText < $1.breedText})) { breed in
                    BreedRow(breed: breed, isFavorite: true, showStar: false, onClick: {})
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}
