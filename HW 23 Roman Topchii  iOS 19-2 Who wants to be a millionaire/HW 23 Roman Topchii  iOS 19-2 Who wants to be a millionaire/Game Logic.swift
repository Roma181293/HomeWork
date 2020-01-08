//
//  Game.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation

struct Question: Hashable{
    var wording : String
    var answers : [String]
    var correctAnswer : Int
}


class Game {
    
    var questionList : [Question]
    var lastquestionIndex : Int = 0
    var gameOver : Bool = false
    
    
    init(questionList : [Question]) {
        self.questionList = questionList
    }
    
    
    func askQuestion() -> Question? {
        if gameOver == false {
            return questionList[lastquestionIndex]
        }
        else {
            return nil
        }
    }
    
    
    func chechAnswer (userAnswer : Int) -> Bool {
        if userAnswer == questionList[lastquestionIndex].correctAnswer {
            lastquestionIndex += 1
            return true
        }
        else {
            gameOver = true
            return false
        }
    }
}
