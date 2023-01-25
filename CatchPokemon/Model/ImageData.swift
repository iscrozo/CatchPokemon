//
//  ImageData.swift
//  CatchPokemon
//
//  Created by Camilo Rozo on 18/01/23.
//

import Foundation

struct ImageData: Codable {
    let sprites: Sprites?
}

// MARK: sprites
class Sprites: Codable {
    let other: Other?
    
    init(other: Other?) {
        self.other = other
    }
}

// MARK: other
struct Other: Codable {
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: officialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
