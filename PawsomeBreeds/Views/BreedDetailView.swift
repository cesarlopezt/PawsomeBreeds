//
//  BreedDetailView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct BreedDetailView: View {
    @EnvironmentObject var favoritesStorage: FavoritesStorage
    @State private var result: Result<[String], Error>?
    var breed: Breed

    var body: some View {
        switch result {
        case .success(let images):
            ScrollView(showsIndicators: false) {
                ImageGrid(images: images)
                    .padding(.vertical)
            }
            .background(breed.color)
            .navigationTitle(breed.breedText)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        favoritesStorage.toggle(breed: breed)
                    } label: {
                        let isFavorite = favoritesStorage.contains(breed)
                        Label("Refresh", systemImage: isFavorite ? "star.fill" : "star")
                            .foregroundColor(isFavorite ? .accentColor : nil)
                    }
                    Button {
                        Task {
                            await BreedLoader.shared.getImages(breed: breed.name, subbreed: breed.subbreed) {
                                result = $0
                            }
                        }
                    } label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    }
                }
            }
        case .failure(let error):
            let _ = print(error)
            Text("Error")
        case nil:
            ProgressView()
                .task {
                    await BreedLoader.shared.getImages(breed: breed.name, subbreed: breed.subbreed) {
                        result = $0
                    }
                }
        }
    }
}

struct BreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BreedDetailView(breed: .init(name: "greyhound", subbreed: "italian"))
        }
    }
}
