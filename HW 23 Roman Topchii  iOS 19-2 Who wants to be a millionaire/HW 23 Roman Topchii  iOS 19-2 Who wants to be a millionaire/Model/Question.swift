//
//  Question.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 12.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation


struct Question : Codable {
    var question : String
    var answers : [String]
    var correctAnswer : Int
    
    
    init(question: String, answers : [String], correctAnswer : Int) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    init(dataQuestion : DataQuestion) {
        if let question = dataQuestion.question{
            self.question = question
        }
        else {
            self.question = ""
        }
        self.correctAnswer = Int(dataQuestion.correctAnswer)
        self.answers = []
        if let answers = dataQuestion.answers{
            for i in 0...answers.count - 1 {
                self.answers.append((dataQuestion.answers![i] as! DataAnswer).answer!)
            }
        }
        else {
            self.answers = ["","","",""]
        }
    }
}

