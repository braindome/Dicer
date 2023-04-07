//
//  GameController.swift
//  Swiftzee
//
//  Created by Antonio on 2023-04-05.
//

import Foundation

class GameController : ObservableObject {
    @Published var game = Game()
    
    func rollDice() -> Int {
        return Int.random(in: 1...game.dieSize)
    }
    
    
}
