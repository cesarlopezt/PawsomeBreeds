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
    @State private var response: BreedImagesResponse? = nil

    var body: some View {
        ScrollView(showsIndicators: false) {
            if let response {
                ImageGrid(images: response.message)
            }
        }
            .navigationTitle(breed.breedText)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if let breedColor = breed.color {
                            Circle().foregroundColor(breedColor.opacity(0.7))
                        }
                        Button {
                            
                        } label: {
                            Label("Refresh", systemImage: "arrow.clockwise")
                        }
                }
            }
            .task {
                do {
                    let url: URL
                    if let subbreed = breed.subbreed {
                        url = URL(string:"https://dog.ceo/api/breed/\(breed.name)/\(subbreed)/images/random/15")!
                    } else {
                        url = URL(string:"https://dog.ceo/api/breed/\(breed.name)/images/random/15")!
                    }
                    var request = URLRequest(url: url)
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpMethod = "GET"
                    
                    let (data, _) = try await URLSession.shared.data(for: request)
                    let res = try JSONDecoder().decode(BreedImagesResponse.self, from: data)
                    print(res)
                    response = res
                } catch {
                    print(error)
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
