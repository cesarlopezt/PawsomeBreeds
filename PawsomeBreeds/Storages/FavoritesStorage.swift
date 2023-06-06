//
//  FavoritesStorage.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

@MainActor class FavoritesStorage: ObservableObject {
    @Published var breeds: Set<Breed>

    private let key = "favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(Set<Breed>.self, from: data) {
                breeds = decoded
                return
            }
        }
        
        breeds = []
    }
    
    func toggle(breed: Breed) {
        if breeds.contains(breed) {
            breeds.remove(breed)
        } else {
            breeds.insert(breed)
        }
        save()
    }
    
    func contains(_ breed: Breed) -> Bool {
        return breeds.contains(breed)
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(breeds) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}

