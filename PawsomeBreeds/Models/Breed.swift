//
//  Breed.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import Foundation

struct BreedList: Codable {
    let breeds: [Breed]

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempBreeds: [Breed] = []
        for key in container.allKeys {
            let subbreeds = try container.decode([String].self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            if subbreeds.isEmpty {
                tempBreeds.append(.init(name: key.stringValue, subbreed: nil))
            } else {
                for subbreed in subbreeds {
                    tempBreeds.append(.init(name: key.stringValue, subbreed: subbreed))
                }
            }
        }
        breeds = tempBreeds.sorted(by: { b1, b2 in
            b1.name < b2.name
        })
    }
}

struct Breed: Hashable, Identifiable, Codable {
    var id = UUID()
    let name: String
    let subbreed: String?
}
