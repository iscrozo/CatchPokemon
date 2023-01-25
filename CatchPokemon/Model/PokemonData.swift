//
//  PokemonData.swift
//  CatchPokemon
//
//  Created by Camilo Rozo on 18/01/23.
//

import Foundation

// MARK: - PokemonData
struct PokemonData: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let url: String?
}
