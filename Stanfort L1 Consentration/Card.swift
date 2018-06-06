//
//  Card.swift
//  Stanfort L1 Consentration
//
//  Created by Иван Дахненко on 06.06.2018.
//  Copyright © 2018 John Dahrah. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
