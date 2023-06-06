//
//  BreedRow.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct BreedRow: View {
    var breed: Breed
    var isFavorite: Bool
    var showStar: Bool
    var onClick: () -> Void
    
    var body: some View {
        NavigationLink {
            BreedDetailView(breed: breed)
        } label: {
            HStack {
                if showStar {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .accentColor : nil)
                        .onTapGesture {
                            onClick()
                        }
                }
                Text("\(breed.breedText)")
            }
        }
        .listRowBackground(breed.color?.opacity(0.3))
    }
}

struct BreedRow_Previews: PreviewProvider {
    static var previews: some View {
        BreedRow(breed: .init(name: "italian", subbreed: "greyhound"), isFavorite: false, showStar: true, onClick: {})
    }
}
