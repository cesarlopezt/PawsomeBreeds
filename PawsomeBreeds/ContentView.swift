//
//  ContentView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            BreedListView()
                .tabItem {
                    Label("Breeds", systemImage: "pawprint.fill")
                }
            VStack {}
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
