//
//  ViewController.swift
//  Stanfort L1 Consentration
//
//  Created by Иван Дахненко on 05.06.2018.
//  Copyright © 2018 John Dahrah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        selectedTheme = -1
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("card isn't in cardButtons")
        }
    }
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
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
    var selectedTheme = -1
    var emojiChoices = Array<String>()
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if selectedTheme == -1 {
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
