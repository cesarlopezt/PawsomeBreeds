//
//  PawsomeBreedsApp.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

@main
struct PawsomeBreedsApp: App {
    @StateObject private var favoritesStorage = FavoritesStorage()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                BreedListView()
                    .tabItem {
                        Label("Breeds", systemImage: "pawprint.fill")
                    }
                FavoritesListView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
            .environmentObject(favoritesStorage)
        }
    }
}
