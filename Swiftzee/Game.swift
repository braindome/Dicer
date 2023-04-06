//
//  Game.swift
//  Swiftzee
//
//  Created by Antonio on 2023-04-05.
//

import Foundation

struct Game {
    var bank = 0
    var betMonies : Int? = 0
    var betNumber : Int = 2
    var diceValue : Int?
    var dieSize : Int = 6
    
    mutating func handleRollResult() {
        if betNumber == diceValue {
            bank = bank + betMonies!
        } else {
            bank = bank - betMonies!
        }
        
    }
    
}
