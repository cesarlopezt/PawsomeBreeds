//
//  BreedDetailView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct ImageGrid: View {
    let colums = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    private let imageWidth = 110.0
    var images: [String]
    
    var body: some View {
        LazyVGrid(columns: colums, alignment: .center, spacing: 5) {
            ForEach(images, id: \.self) { image in
                AsyncImage(url: URL(string: image)!) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageWidth)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .failure(let error):
                        let _ = print(error)
                        Text("Error")
                            .frame(width: imageWidth, height: imageWidth)
                    case .empty:
                        ProgressView()
                            .frame(width: imageWidth, height: imageWidth)
                    @unknown default:
                        Image(systemName: "questionmark")
                    }
                }
            }
        }
    }
    
}

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
