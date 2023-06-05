//
//  ContentView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct Cell: View {
    var breed: Breed
    
    var body: some View {
        if let subbreed = breed.subbreed {
            Text("\(subbreed) \(breed.name)")
        } else {
            Text("\(breed.name)")
        }
    }
}

struct ContentView: View {
    @State private var response: BreedListResponse? = nil
    var body: some View {
        List {
            if let response {
                ForEach(response.message.breeds) { breed in
                    Cell(breed: breed)
                }
            }
        }
        .task {
            do {
                let url = URL(string:"https://dog.ceo/api/breeds/list/all")!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "GET"
                
                let (data, _) = try await URLSession.shared.data(for: request)
                let res = try JSONDecoder().decode(BreedListResponse.self, from: data)
                print(res)
                response = res
            } catch {
                print(error)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
