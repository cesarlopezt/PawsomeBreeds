//
//  BreedRow.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct BreedRow: View {
    var breed: Breed
    
    var body: some View {
        NavigationLink {
            BreedDetailView(breed: breed)
        } label: {
            Text("\(breed.breedText)")
        }
        .listRowBackground(breed.color?.opacity(0.3))
    }
}

struct BreedRow_Previews: PreviewProvider {
    static var previews: some View {
        BreedRow(breed: .init(name: "italian", subbreed: "greyhound"))
    }
}
