//
//  Responses.swift
//  PawsomeBreeds
//
//  Created by Cesar Lopez on 6/5/23.
//

import Foundation

struct Response<Message: Codable>: Codable {
    let message: Message
    let status: String
}
