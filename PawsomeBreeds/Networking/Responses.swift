//
//  Responses.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import Foundation

struct BreedListResponse: Codable {
    let message: BreedList
    let status: String
}

struct BreedImagesResponse: Codable {
    let message: [String]
    let status: String
}
