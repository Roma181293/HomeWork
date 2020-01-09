//
//  Game.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation

struct Question{
    var question : String
    var answers : [String]
    var correctAnswer : Int
}


class Game {
    
    var questionList : [Question]
    var currentQuestionIndex : Int = 0
    let prize : [Int] = [500,1000,2000,3000,5000,10000,15000,25000,50000,100000,200000,400000,800000,1000000]
    var gameOver : Bool = false
    
    
    init(questionList : [Question]) {
        print("Start game")
        self.questionList = questionList
    }
    
    
    func askQuestion() -> Question? {
         print(#function, currentQuestionIndex)
        if gameOver == false {
            print(questionList[currentQuestionIndex])
            return questionList[currentQuestionIndex]
        }
        else {
            print("Game over. There is no more questions!!")
            return nil
        }
    }
    
    
    func checkAnswer (userAnswer : Int) -> (correctAnsver : Bool, gameOver : Bool) {
        
        if userAnswer == questionList[currentQuestionIndex].correctAnswer {
            print("Correct answer")
            currentQuestionIndex += 1

            if currentQuestionIndex >= questionList.count {
                gameOver = true
                currentQuestionIndex -= 1
            }
            print(#function, currentQuestionIndex,gameOver)
            return (true,gameOver)
        }
        else {
            gameOver = true
            print("Wrong answer")
            return (false,gameOver)
        }
    }
    
    
}
