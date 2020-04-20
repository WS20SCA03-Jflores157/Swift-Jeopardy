//
//  ViewController.swift
//  Swift Jeopardy
//
//  Created by Jeffrey  on 4/20/20.
//  Copyright © 2020 BMCC. All rights reserved.
//

import UIKit

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
    

    struct Questions {
        let question: String
        let answer: String
        let value: Int
    }
    
    let qAndA: [Questions] =
    [
Questions(question: "Inspector that lets you change the text font.", answer: "What is a Attributes Inspector",
          value: 200),
Questions(question: "The name given to the parameter of a function.", answer: "What is a Argument Label", value: 200),
Questions(question: "Data Type that has characters within double quotes", answer: "What is a String", value: 200),
Questions(question: "Editor that lets you connect buttons and labels.", answer: "What is an Assistant Editor", value: 500),
Questions(question: "A function that returns a value.", answer: "What is a return function", value: 500),
Questions(question: "Function called to run a case insensitive comparison on strings.", answer: "What is .lowercased", value: 500),
Questions(question: "Select your entire code and indent format all text.", answer: "What does command a and command i do to your code", value: 1000),
Questions(question: "A function inside a struct that lets you change the properties.", answer: "What is a mutating func", value: 1000),
Questions(question: "Function called to get the first character of String.", answer: "What is .startIndex", value: 1000)
    
    
    ]
    
    var questionNumber: Int!
    var player1: Bool = false
    var player2: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        answerField.isEnabled = false
    }
    
  
    
    
    @IBAction func valuePressed(_ sender: UIButton) {
        sender.setTitle("\(qAndA[sender.tag].question)", for: .normal)
        questionNumber = sender.tag
    }
    
    @IBAction func player1Button(_ sender: UIButton) {
        playerButton2.isEnabled = false
        player2Label.alpha = 0.5
        player2Score.alpha = 0.5
        answerField.isEnabled = true
        player1 = true
    }
    
    
    @IBAction func player2Button(_ sender: Any) {
        playerButton1.isEnabled = false
        player1Label.alpha = 0.5
        player1Score.alpha = 0.5
        answerField.isEnabled = true
        player2 = true
        
    }
    
    func resetUI(){
        answerField.isEnabled = false
        playerButton1.isEnabled = true
        playerButton2.isEnabled = true
        player1Label.alpha = 1.0
        player2Label.alpha = 1.0
        answerField.text = ""
        answerMessage.text = ""
    }
    
    func addScore(player:UILabel){
        let currentScore: Int = Int(player1Score.text!)!
        
        player.text = "\(currentScore + qAndA[questionNumber].value)"
        
        valueButtons[questionNumber].setTitle("", for: .normal)
        
        valueButtons[questionNumber].isEnabled = false
        
        answerMessage.text = "That is Correct!"
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
                resetUI()
      
            }
            else if player2 == true {
                
                addScore(player: player2Score)
                resetUI()
            }
            
        }
        
        else {
            answerMessage.text = "Wrong Answer. Next Player's Turn."
            
            if player1 == true {
                player1 = false
                player2 = true
                playerButton1.isEnabled = false
                playerButton2.isEnabled = true
                player1Label.alpha = 0.5
                player1Score.alpha = 0.5
                player2Label.alpha = 1.0
                player2Score.alpha = 1.0
                
            }
            else if player2 == true {
                player2 = false
                player1 = true
                playerButton2.isEnabled = false
                playerButton1.isEnabled = true
                player2Label.alpha = 0.5
                player2Score.alpha = 0.5
                player1Label.alpha = 1.0
                player1Score.alpha = 1.0
            }
            
        }
    }
    
    
}

