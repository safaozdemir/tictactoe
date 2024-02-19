//
//  ViewController.swift
//  xox
//
//  Created by Muhammed Safa Ozdemir on 19.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    enum Player {
            case Circle
            case Cross
        }

    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    
    var startingPlayer = Player.Cross
        var currentPlayer = Player.Cross

        var CIRCLE = "O"
        var CROSS = "X"
        var gameBoard = [UIButton]()

        var circleScore = 0
        var crossScore = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            setupGameBoard()
        }

        func setupGameBoard() {
            gameBoard.append(a1)
            gameBoard.append(a2)
            gameBoard.append(a3)
            gameBoard.append(b1)
            gameBoard.append(b2)
            gameBoard.append(b3)
            gameBoard.append(c1)
            gameBoard.append(c2)
            gameBoard.append(c3)
        }

        @IBAction func cellTapped(_ sender: UIButton) {
            addToBoard(sender)

            if checkForVictory(CROSS) {
                crossScore += 1
                resultAlert(title: "Crosses Win!")
            }

            if checkForVictory(CIRCLE) {
                circleScore += 1
                resultAlert(title: "Circles Win!")
            }

            if fullBoard() {
                resultAlert(title: "Draw")
            }
        }

        
    func checkForVictory(_ s :String) -> Bool
        {
            // Horizontal Victory
            if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
            {
                return true
            }
            if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
            {
                return true
            }
            if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
            {
                return true
            }
            
            // Vertical Victory
            if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
            {
                return true
            }
            if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
            {
                return true
            }
            if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
            {
                return true
            }
            
            // Diagonal Victory
            if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
            {
                return true
            }
            if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
            {
                return true
            }
            
            return false
        }
        
        func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
        {
            return button.title(for: .normal) == symbol
        }
        
    func resultAlert(title: String) {
            let message = "\nCircles " + String(circleScore) + "\n\nCrosses " + String(crossScore)
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                self.resetBoard()
            }))
            self.present(ac, animated: true)
        }

        func resetBoard() {
            for button in gameBoard {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if startingPlayer == Player.Circle {
                startingPlayer = Player.Cross
                turnLabel.text = CROSS
            } else if startingPlayer == Player.Cross {
                startingPlayer = Player.Circle
                turnLabel.text = CIRCLE
            }
            currentPlayer = startingPlayer
        }

        func fullBoard() -> Bool {
            for button in gameBoard {
                if button.title(for: .normal) == nil {
                    return false
                }
            }
            return true
        }

        func addToBoard(_ sender: UIButton) {
            if sender.title(for: .normal) == nil {
                if currentPlayer == Player.Cross {
                    sender.setTitle(CROSS, for: .normal)
                    currentPlayer = Player.Circle
                    turnLabel.text = CIRCLE
                } else if currentPlayer == Player.Circle {
                    sender.setTitle(CIRCLE, for: .normal)
                    currentPlayer = Player.Cross
                    turnLabel.text = CROSS
                }
                sender.isEnabled = false
            }
        }
    }
