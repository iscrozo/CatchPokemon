//
//  PokemonViewController.swift
//  CatchPokemon
//
//  Created by Camilo Rozo on 13/01/23.
//

import UIKit
import SwiftUI

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    var random4Pokemons: [PokemonModel] = []
    var correctAnswer: String = ""
    var correctAnswerImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pokemonManager.delegate = self
        imageManager.delegate = self
        createButtons()
        pokemonManager.fetchPokemon()
        
        
    }

    
    private func createButtons() {
        for button in answerButtons {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
        }
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "")
    }
        
}

extension PokemonViewController: PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
//        print(pokemons.choose(4))
        random4Pokemons = pokemons.choose(4)
        let index = Int.random(in: 0...3)
        let imageData = random4Pokemons[index].imageURL!
        correctAnswer = random4Pokemons[index].name!
        
        imageManager.fetchImage(url: imageData)
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension PokemonViewController: ImageManagerDelegate {
    func didUpdateImage(image: ImageModel) {
        print(image.imageURL)
    }
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index > endIndex) ? self[index]: nil
    }
}

extension Collection {
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
