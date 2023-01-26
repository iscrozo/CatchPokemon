//
//  PokemonManager.swift
//  CatchPokemon
//
//  Created by Camilo Rozo on 18/01/23.
//

import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel])
    func didFailWithError(error: Error)
}

struct PokemonManager {
    
    private let pokemonURL: String = "https://pokeapi.co/api/v2/pokemon?limit=898"
    var delegate: PokemonManagerDelegate?
    
    
    func fetchPokemon() {
        performRequest(with: pokemonURL)
    }

    private func performRequest(with urlString: String) {
        //    1 create get/url
        if let url = URL(string: urlString) {
        //    2 create the urlSession
            let session = URLSession(configuration: .default)
        //    3 give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
//                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let pokemon = self.parseJson(pokemonData: safeData) {
//                        print(pokemon)
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                    }
                }
            }
            //    4 start the task
            task.resume()
        }
        
        
    }
    
    private func parseJson(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map{
                PokemonModel(name: $0.name!, imageURL: $0.url!)
            }
            return pokemon
        } catch {
            return nil
        }
    }
    
}
