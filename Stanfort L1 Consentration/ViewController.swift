//
//  ViewController.swift
//  Stanfort L1 Consentration
//
//  Created by Иван Дахненко on 05.06.2018.
//  Copyright © 2018 John Dahrah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //lazy - dont init until it's used
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        //invoked when variable changes (property observer)
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        selectedTheme = 0
        flipCount = 0
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("card isn't in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices { // = 0..<cardButtons.count
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
    }
    
    let emojiThemes = [["😀", "😂", "😇", "😍", "😋", "😎", "😱"],
                       ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻"],
                       ["💟", "☮️", "✝️", "☪️", "🕉", "☸️", "🕎"]]
    var selectedTheme = 0
    var emojiChoices = Array<String>()
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if selectedTheme == 0 {
            selectedTheme = Int(arc4random_uniform(UInt32(emojiThemes.count)))
            emojiChoices = emojiThemes[selectedTheme]
        }
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
