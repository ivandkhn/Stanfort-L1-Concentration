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
    @IBOutlet var backgroundViewController: UIView!
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        selectedTheme = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        emojiChoices = emojiThemes[selectedTheme]
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if selectedTheme == -1 {
            selectedTheme = Int(arc4random_uniform(UInt32(emojiThemes.count)))
            emojiChoices = emojiThemes[selectedTheme]
        }
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : colorThemes[selectedTheme][1]
            }
        }
        backgroundViewController.backgroundColor = colorThemes[selectedTheme][0]
    }
    
    let emojiThemes = [["😀", "😂", "😇", "😍", "😋", "😎", "😱"],
                       ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻"],
                       ["💟", "☮️", "✝️", "☪️", "🕉", "☸️", "🕎"]]
    let colorThemes = [[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                       [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)],
                       [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]]
    var selectedTheme = -1
    var emojiChoices = Array<String>()
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
