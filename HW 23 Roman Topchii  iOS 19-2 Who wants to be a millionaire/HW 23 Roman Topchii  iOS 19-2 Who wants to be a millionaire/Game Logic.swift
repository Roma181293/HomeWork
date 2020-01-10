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
    var history : [String : String] = [:]
    
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
    
    
    func checkAnswer (userAnswer : Int) -> (correctAnswer : Bool, gameOver : Bool) {
        
        if userAnswer == questionList[currentQuestionIndex].correctAnswer {
            print("Correct answer")
            if currentQuestionIndex + 1 >= questionList.count {
                gameOver = true
            }
            return (true,gameOver)
        }
        else {
            gameOver = true
            print("Wrong answer")
            return (false,gameOver)
        }
    }
    
    func nextQuestion() {
        if currentQuestionIndex+1 != questionList.count {
            currentQuestionIndex += 1
        }
    }
    func addToHistory(userAnswer : Int) {
        history["\(questionList[currentQuestionIndex].question)"] = "\(questionList[currentQuestionIndex].answers[userAnswer]))"
    }
    
    func saveResults() {
        //определение текущего времени
        let date = Date()
       
        history["\(prize)"] = "\(prize[currentQuestionIndex])"
        history["winner"] = ""
        
        
        
        //запиcать ответы играка в plist
        //получение папки Documents
        let docsBaseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //получение полного пути файла
        let gameArchivePlistURL = docsBaseURL.appendingPathComponent("gameArchive.plist")
        //сохранение customDict в файл customPlistURL
        
        if var customDictRead : [String : [String : String]] = NSDictionary (contentsOf: gameArchivePlistURL) as? [String : [String : String]] {
            customDictRead["\(date)"] = history
            NSDictionary(dictionary : customDictRead).write(to: gameArchivePlistURL, atomically: true)
        }
        else {
            NSDictionary(dictionary : ["\(date)" : history]).write(to: gameArchivePlistURL, atomically: true)
        }
        print(#function)
    }
    
    
    
    
//    func saveResults1() {
//        //определение текущего времени
//        let date = Date()
//       
//        //запиcать ответы играка в plist
//        //получение папки Documents
//        let docsBaseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        //получение полного пути файла
//        let gameArchivePlistURL = docsBaseURL.appendingPathComponent("gameArchive.plist")
//        //сохранение customDict в файл customPlistURL
//        
//        if var customDictRead : [String : Array<String>] = NSDictionary (contentsOf: gameArchivePlistURL) as? [String : Array<String>] {
//            customDictRead["\(date)"] = history
//            NSDictionary(dictionary : customDictRead).write(to: gameArchivePlistURL, atomically: true)
//        }
//        else {
//            NSDictionary(dictionary : ["\(date)" : history]).write(to: gameArchivePlistURL, atomically: true)
//        }
//        print(#function)
//    }
    
}
