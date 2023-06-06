//
//  ImageViewerView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/6/23.
//

import SwiftUI

struct ImageViewerView: View {
    var image: String

    var body: some View {
        VStack {
            CacheAsyncImage(url: URL(string: image)!) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let error):
                    let _ = print(error)
                    Text("Error")
                case .empty:
                    ProgressView()
                @unknown default:
                    Image(systemName: "questionmark")
                }
            }
        }
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView(image: "https://images.dog.ceo/breeds/lhasa/n02098413_10590.jpg")
    }
}
