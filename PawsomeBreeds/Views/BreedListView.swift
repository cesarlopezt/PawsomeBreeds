//
//  BreedListView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct BreedListView: View {
    @EnvironmentObject var favoritesStorage: FavoritesStorage
    @State private var result: Result<[Breed], Error>?

    var body: some View {
        NavigationView {
            switch result {
            case .success(let breeds):
                List {
                    ForEach(breeds) { breed in
                        BreedRow(breed: breed, isFavorite: favoritesStorage.contains(breed), showStar: true) {
                                favoritesStorage.toggle(breed: breed)
                            }
                    }
                }
                .navigationTitle("Breeds")
            case .failure(let error):
                let _ = print(error)
                Text("Error")
            case nil:
                ProgressView()
                    .navigationTitle("Breeds")
                    .task {
                        await BreedLoader.shared.getAll {
                            result = $0
                        }
                    }
            }
        }
    }
}

struct BreedListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedListView()
    }
}
