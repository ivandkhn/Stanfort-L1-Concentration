//
//  ViewController.swift
//  Stanfort L1 Consentration
//
//  Created by Иван Дахненко on 05.06.2018.
//  Copyright © 2018 John Dahrah. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var backgroundViewController: UIView!
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction private func newGameButtonPressed(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        //selectedTheme = emojiThemes.count.arc4random
        emojiChoices = emojiThemes[selectedTheme]
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        assert(emojiThemes.count == colorThemes.count, "emojiThemes.count != colorThemes.count")
        emojiChoices = emojiThemes[selectedTheme]
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("card isn't in cardButtons")
        }
    }
    private func updateViewFromModel() {
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
        newGameButton.backgroundColor = colorThemes[selectedTheme][1]
        scoreLabel.textColor = colorThemes[selectedTheme][1]
        flipCountLabel.textColor = colorThemes[selectedTheme][1]
    }
    
    //MARK: emoji to show
    private let emojiThemes = [["😀", "😂", "😇", "😍", "😋", "😎", "😱"],
                               ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻"],
                               ["💟", "☮️", "✝️", "☪️", "🕉", "☸️", "🕎"]]
    private let colorThemes = [[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                               [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)],
                               [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]]
    var selectedTheme = 0
    private var emojiChoices = Array<String>()
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return  Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
