//
//  BreedLoader.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import Foundation

class BreedLoader {
    enum BreedLoaderError: Error {
        case invalidURL
        case notFound
    }
    
    static let shared = BreedLoader()
    
    private let urlSession = URLSession.shared
    let baseURL = "https://dog.ceo/api"

    func getAll() async -> Result<[Breed], Error> {
        do {
            guard let url = URL(string: "\(baseURL)/breeds/list/all") else {
                throw BreedLoaderError.invalidURL
            }
            let response: BreedList = try await self.get(url: url)
            return .success(response.breeds)
        } catch {
            return .failure(error)
        }
    }
    
    func getImages(breed: String, subbreed: String? = nil, num: Int = 15) async -> Result<[String], Error> {
        do {
            let identifier: String
            if let subbreed {
                identifier = "\(breed)/\(subbreed)"
            } else {
                identifier = breed
            }
            
            guard let url = URL(string: "\(baseURL)/breed/\(identifier)/images/random/\(num)") else {
                throw BreedLoaderError.invalidURL
            }
            let response: [String] = try await self.get(url: url)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    private func get<Message: Codable>(url: URL) async throws -> Message {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedResponse = try JSONDecoder().decode(Response<Message>.self, from: data)
        if decodedResponse.status == "error" {
            throw BreedLoaderError.notFound
        }
        return decodedResponse.message
    }
}
