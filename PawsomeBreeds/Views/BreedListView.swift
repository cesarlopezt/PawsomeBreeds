//
//  BreedListView.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

struct Row: View {
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

struct BreedListView: View {
    @State private var response: BreedListResponse? = nil

    var body: some View {
        NavigationView {
            List {
                if let response {
                    ForEach(response.message.breeds) { breed in
                        Row(breed: breed)
                    }
                }
            }
            .navigationTitle("Breeds")
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
}

struct BreedListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedListView()
    }
}
