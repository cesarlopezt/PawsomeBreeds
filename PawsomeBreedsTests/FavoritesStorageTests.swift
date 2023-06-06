//
//  FavoritesStorageTests.swift
//  PawsomeBreedsTests
//
//  Created by Cesar Lopez on 6/6/23.
//

import XCTest

@MainActor final class FavoritesStorageTests: XCTestCase {
    var storage: FavoritesStorage!
    let key = "favorites"
    let breed = Breed(name: "greyhound", subbreed: "italian")

    override func setUp() {
        super.setUp()
        storage = FavoritesStorage()
        storage.breeds = []
        UserDefaults.standard.removeObject(forKey: key)
    }

    override func tearDown() {
        storage = nil
        super.tearDown()
    }

    func testAddBreed() {
        XCTAssertFalse(storage.contains(breed))
        storage.toggle(breed: breed)
        XCTAssertTrue(storage.contains(breed))
    }
    
    func testUserDefaultsContainsAddedBreed() {
        XCTAssertFalse(UserDefaults.standard.dictionaryRepresentation().keys.contains(key))
        storage.toggle(breed: breed)
        XCTAssertTrue(UserDefaults.standard.dictionaryRepresentation().keys.contains(key))

        let data = UserDefaults.standard.data(forKey: key)
        XCTAssertNotNil(data)
        let decodedBreeds = try? JSONDecoder().decode(Set<Breed>.self, from: data!)
        XCTAssertNotNil(decodedBreeds)
        XCTAssertTrue(decodedBreeds!.contains(breed))
    }
    
    func testRemoveBreed() {
        XCTAssertFalse(storage.contains(breed))
        storage.toggle(breed: breed)
        XCTAssertTrue(storage.contains(breed))
        
        storage.toggle(breed: breed)
        XCTAssertFalse(storage.contains(breed))
        XCTAssertEqual(storage.breeds, [])
    }
}
