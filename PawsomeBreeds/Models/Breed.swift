//
//  Breed.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import SwiftUI

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
            b1.breedText < b2.breedText
        })
    }
}

struct Breed: Hashable, Identifiable, Codable {
    var id: String {
        return "\(name)_\(subbreed ?? "")"
    }
    let name: String
    let subbreed: String?
    
    var breedText: String {
        if let subbreed {
            return "\(subbreed) \(name)".capitalized
        } else {
            return "\(name)".capitalized
        }
    }
    
    var color: Color? {
        switch (breedText) {
        case "Whippet":
            return Color.pink
        case "Italian Greyhound":
            return Color.purple
        default:
            return nil
        }
    }
}
