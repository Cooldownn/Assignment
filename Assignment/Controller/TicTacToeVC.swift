//
//  TicTacToeVC.swift
//  Assignment
//
//  Created by Cooldown on 15/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class TicTacToeVC: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    
    let winningCombinations = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    var playerOneMoves = Set<Int>()
    var playerTwoMoves = Set<Int>()
    var possibleMove = Array<Int>()
    var playerTurn = 1
    var nextMove: Int? = nil
    let allSpaces: Set<Int> = [1,2,3,4,5,6,7,8,9]
    
    @IBAction func newGameButton(_ sender: AnyObject) {
        
        newGame()
        
    }
    
    @IBAction func buttonClicked(_ sender: AnyObject) {
        
        
        if playerOneMoves.contains(sender.tag) || playerTwoMoves.contains(sender.tag) {
            statusLabel.text = "Try Again"
        } else {
            if playerTurn % 2 != 0 {
                
                // add space to player move list
                playerOneMoves.insert(sender.tag)
                sender.setImage(UIImage(named:"Cross.png"), for: UIControlState())
                playerTurn = 2
                statusLabel.text = "Player Two's Turn"
                if isWinner(player: 1) == 0 {
                    
                    let nextMove = playDefense()
                    playerTwoMoves.insert(nextMove)
                    let button = self.view.viewWithTag(nextMove) as! UIButton
                    button.setImage(UIImage(named: "Nought.png"), for: UIControlState())
                    playerTurn = 1
                    statusLabel.text = "Your Turn"
                    statusLabel.textColor = UIColor.init(cgColor: #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1))
                    
                    isWinner(player: 2)
                }
            }
            
            playerTurn = +1
            if (playerTurn > 9 && isWinner(player: 1) < 1) {
                statusLabel.text = "Draw"
                for index in 1...9 {
                    let button = self.view.viewWithTag(index) as! UIButton
                    button.isEnabled = false
                }
            }
        }
    }
    
    
    func newGame() {
        
        // clear move list
        playerOneMoves.removeAll()
        playerTwoMoves.removeAll()
        
        // change status label and set player turn
        statusLabel.text = "You Go First !!!"
        statusLabel.textColor = UIColor.init(cgColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        playerTurn = 1
        
        // setup titles
        
        for index in 1...9 {
            let title = self.view.viewWithTag(index) as! UIButton
            title.isEnabled = true
            title.setImage(nil, for: UIControlState())
        }
        
    }
    
    func isWinner(player: Int) -> Int {
        
        var winner = 0
        var moveList = Set<Int>()
        
        if player == 1 {
            moveList = playerOneMoves
        } else {
            moveList = playerTwoMoves
        }
        
        // check if there is winning condition
        for combo in winningCombinations {
            if moveList.contains(combo[0]) && moveList.contains(combo[1]) && moveList.contains(combo[2]) && moveList.count > 2 {
                winner = player
                if winner == 1 {
                    statusLabel.text = "You Won!"
                    statusLabel.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
                }
                else if winner == 2 {
                    statusLabel.text = "GG! Loser"
                    statusLabel.textColor = UIColor.init(cgColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                }
                for index in 1...9 {
                    let title = self.view.viewWithTag(index) as! UIButton
                    title.isEnabled = false
                }
            }
        }
        return winner
    }
    
    func playDefense() -> Int {
        var possibeLoses = Array<Array<Int>>()
        var possibleWins = Array<Array<Int>>()
        let spacesLeft = allSpaces.subtracting(playerOneMoves.union(playerTwoMoves))
        
        for combo in winningCombinations {
            var count = 0
            
            for play in combo {
                if playerOneMoves.contains(play) {
                    count = +1
                }
                if playerTwoMoves.contains(play) {
                    count = -1
                }
                if count == 2 {
                    possibeLoses.append(combo)
                    count = 0
                }
                if count == -2 {
                    possibleWins.append(combo)
                    count = 0
                }
            }
        }
        if possibleWins.count > 0 {
            for combo in possibleWins {
                for space in combo {
                    if !(playerOneMoves.contains(space) || playerTwoMoves.contains(space)) {
                        return space
                    }
                }
            }
        }
        
        if possibeLoses.count > 0 {
            for combo in possibeLoses {
                for space in combo {
                    if !(playerOneMoves.contains(space) || playerTwoMoves.contains(space)) {
                        possibleMove.append(space)
                    }
                }
            }
        }
        
        if possibleMove.count > 0 {
            nextMove = possibleMove[Int(arc4random_uniform(UInt32(possibleMove.count)))]
        } else if (allSpaces.subtracting(playerOneMoves.union(playerTwoMoves))).count > 0 {
            nextMove = spacesLeft[spacesLeft.index(spacesLeft.startIndex, offsetBy: Int(arc4random_uniform(UInt32(spacesLeft.count))))]
        }
        
        possibleMove.removeAll()
        possibeLoses.removeAll()
        possibleWins.removeAll()
        playerTurn = +1
        return nextMove!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        newGame()
    }


}
