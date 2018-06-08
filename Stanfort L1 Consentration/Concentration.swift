//
//  Concentration.swift
//  Stanfort L1 Consentration
//
//  Created by Иван Дахненко on 06.06.2018.
//  Copyright © 2018 John Dahrah. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var score = 0
    var flipCount = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[matchIndex].wasInvolvedInMismatch {
                        score -= 1
                    }
                    if cards[index].wasInvolvedInMismatch {
                        score -= 1
                    }
                    cards[matchIndex].wasInvolvedInMismatch = true
                    cards[index].wasInvolvedInMismatch = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        for _ in 1...numberOfPairsOfCards*2 {
            let i = Int(arc4random_uniform(UInt32(numberOfPairsOfCards*2)))
            let j = Int(arc4random_uniform(UInt32(numberOfPairsOfCards*2)))
            cards.swapAt(i, j)
        }
    }
}
