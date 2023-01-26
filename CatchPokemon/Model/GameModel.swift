//
//  GameModel.swift
//  CatchPokemon
//
//  Created by Camilo Rozo on 18/01/23.
//

import Foundation

struct GameModel {
    var score = 0
    
    // Revisar si la rta es correcta
    mutating func checkAnswer(_ userAnswer: String, _ correctAnswer: String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    // obtener score
    func getScore() -> Int {
        return score
    }
    
    // Reiniciar score
    mutating func setScore(score: Int) {
        self.score = score
    }
}
