//
//  BreedDetailView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct BreedDetailView: View {
    var breed: Breed
    @State private var result: Result<[String], Error>?

    var body: some View {
        switch result {
        case .success(let images):
            ScrollView(showsIndicators: false) {
                ImageGrid(images: images)
            }
            .background(breed.color.opacity(0.3))
            .navigationTitle(breed.breedText)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
