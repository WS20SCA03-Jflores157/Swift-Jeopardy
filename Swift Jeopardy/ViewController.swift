//
//  ViewController.swift
//  Swift Jeopardy
//
//  Created by Jeffrey  on 4/20/20.
//  Copyright © 2020 BMCC. All rights reserved.
//

import UIKit

struct Questions {
    let question: String
    let answer: String
    let value: Int
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var playerButton1: UIButton!
    @IBOutlet weak var playerButton2: UIButton!
    
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    
    @IBOutlet weak var answerMessage: UILabel!
    
    
    @IBOutlet weak var player1Winner: UILabel!
    @IBOutlet weak var player2Winner: UILabel!
    
    @IBOutlet var valueButtons: [UIButton]!
    
    @IBOutlet weak var answerField: UITextField!
    
    @IBOutlet weak var newGameBtn: UIButton!
    
    
    //Array of structs questions and answers
    let qAndA: [Questions] =
        [
            Questions(question: "Inspector that lets you change the text font.", answer: "What is a Attributes Inspector?",
                      value: 200),
            Questions(question: "The name given to the parameter of a function.", answer: "What is a Argument Label?", value: 200),
            Questions(question: "Data Type that has characters within double quotes", answer: "What is a String?", value: 200),
            Questions(question: "Editor that lets you connect buttons and labels.", answer: "What is an Assistant Editor?", value: 500),
            Questions(question: "A function that returns a value.", answer: "What is a return function?", value: 500),
            Questions(question: "Function called to run a case insensitive comparison on strings.", answer: "What is .lowercased?", value: 500),
            Questions(question: "Select your entire code and indent format all text.", answer: "What does command a and command i do to your code?", value: 1000),
            Questions(question: "A function inside a struct that lets you change the properties.", answer: "What is a mutating func?", value: 1000),
            Questions(question: "Function called to get the first character of String.", answer: "What is .startIndex?", value: 1000)
            
            
    ]
    
    var questionNumber: Int! //keep track of question
    var player1: Bool = false //keep track of current player
    var player2: Bool = false
    var questionCount: Int = 0 //keep track of questions answered
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartUI()
    }
    
    //restart UI of game
    func restartUI(){
        newGameBtn.isEnabled = false
        newGameBtn.alpha = 0.5
        player2Winner.text = ""
        player1Winner.text = ""
        player1Score.text = "0"
        player2Score.text = "0"
        player1Label.alpha = 1.0
        player2Label.alpha = 1.0
        playerButton1.isEnabled = true
        playerButton2.isEnabled = true
        answerField.isEnabled = false
        player1 = false
        player2 = false
        
        
        
        for i in 0 ..< valueButtons.count {
            let value: String = String(qAndA[i].value)
            
            valueButtons[i].setTitle(value, for: .normal)
            
            valueButtons[i].isEnabled = true
        }
        
    }
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        restartUI()
        
    }
    
    
    @IBAction func valuePressed(_ sender: UIButton) {
        sender.setTitle("\(qAndA[sender.tag].question)", for: .normal)
        questionNumber = sender.tag
    }
    
    
    @IBAction func playerButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            playerButton2.isEnabled = false
            player2Label.alpha = 0.5
            player2Score.alpha = 0.5
            answerField.isEnabled = true
            player1 = true
        case 1:
            playerButton1.isEnabled = false
            player1Label.alpha = 0.5
            player1Score.alpha = 0.5
            answerField.isEnabled = true
            player2 = true
        default:
            print("Default print statement.")
        }
        
    }
    
    
    //add score for correct answer, reset players, check for winner
    func addScore(player:UILabel){
        let currentScore: Int = Int(player.text!)!
        
        player.text = "\(currentScore + qAndA[questionNumber].value)"
        
        valueButtons[questionNumber].setTitle("", for: .normal)
        
        valueButtons[questionNumber].isEnabled = false
        
        answerMessage.text = "That is Correct!"
        
        answerField.isEnabled = false
        playerButton1.isEnabled = true
        playerButton2.isEnabled = true
        player1Label.alpha = 1.0
        player2Label.alpha = 1.0
        answerField.text = ""
        answerMessage.text = ""
        player1 = false
        player2 = false
        questionCount += 1
        
        if questionCount == 9{
            let player1: Int = Int(player1Score.text!)!
            let player2: Int = Int(player2Score.text!)!
            newGameBtn.isEnabled = true
            newGameBtn.alpha = 1.0
            
            if player1 > player2 {
                player1Winner.text = "Winner"
            }
            else if player2 > player1 {
                player2Winner.text = "Winner"
            }
        }
    }
    
    func wrongAnswer(playerBtnEnabled1: UIButton, playerBtnEnabled2: UIButton, playerLblAlpha1: UILabel, playerLblAlpha2: UILabel, playerScoreAlpha1: UILabel, playerScoreAlpha2: UILabel){
        
        playerBtnEnabled1.isEnabled = false
        playerBtnEnabled2.isEnabled = true
        
        playerLblAlpha1.alpha = 0.5
        playerScoreAlpha1.alpha = 0.5
        
        playerLblAlpha2.alpha = 1.0
        playerScoreAlpha2.alpha = 1.0
        
        answerField.text = ""
        answerMessage.text = "Wrong Answer. Next Player's Turn."
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let playerAnswer: String? = textField.text?.lowercased()
        
        if playerAnswer == qAndA[questionNumber].answer.lowercased() {
            
            
            if player1 == true {
                
                addScore(player: player1Score)
                
            }
            else if player2 == true {
                
                addScore(player: player2Score)
                
            }
            
        }
            
        else {
            
            
            if player1 == true {
                player2 = true
                player1 = false
                wrongAnswer(playerBtnEnabled1: playerButton1, playerBtnEnabled2: playerButton2, playerLblAlpha1: player1Label, playerLblAlpha2: player2Label, playerScoreAlpha1: player1Score, playerScoreAlpha2: player2Score)
                
            }
            else if player2 == true {
                player2 = false
                player1 = true
                wrongAnswer(playerBtnEnabled1: playerButton2, playerBtnEnabled2: playerButton1, playerLblAlpha1: player2Label, playerLblAlpha2: player1Label, playerScoreAlpha1: player2Score, playerScoreAlpha2: player1Score)
                
            }
            
        }
    }
    
    
}

