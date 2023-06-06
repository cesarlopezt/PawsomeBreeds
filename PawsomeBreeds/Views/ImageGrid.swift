//
//  ImageGrid.swift
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


struct ImageGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImageGrid(images: [
            "https://images.dog.ceo/breeds/lhasa/n02098413_10590.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_11048.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_1454.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_1702.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_1784.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_18317.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_20614.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_2402.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_2536.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_2584.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_2911.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_3285.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_5806.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_754.jpg",
            "https://images.dog.ceo/breeds/lhasa/n02098413_932.jpg"
        ])
    }
}
