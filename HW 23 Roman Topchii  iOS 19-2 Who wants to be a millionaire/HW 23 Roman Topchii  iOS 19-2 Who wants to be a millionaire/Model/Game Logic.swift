//
//  Game.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation

class Game {
    
    
    static var share : Game = Game()
    
    private init() {
        print("Game",#function, "singlton")
    }
    
    
    private var questionList : [Question] = []
    private var currentQuestionIndex : Int = 0
    
    private let prizeArray : [Int] = [500,1000,2000,3000,5000,10000,15000,25000,50000,100000,200000,400000,800000,1000000]
    
    private var gameOver : Bool = false
    private var looseGame = false
    
    private var currentPrize : Int {
        if looseGame == false {
            return prizeArray[currentQuestionIndex]
        }
        else {
            return 0
        }
    }
    
    private var askedQuestions : [String] = []
    private var answersForAskedQuestions : [String] = []
    
    private var friendIsAlredyHelpt : Bool = false
    private var audienceIsAlredyHelpt : Bool = false
    
    
    
    func newGame() {
        questionList = readFromQuestionsList()
        currentQuestionIndex = 0
        gameOver = false
        looseGame = false
        askedQuestions = []
        answersForAskedQuestions = []
        
        print("Game",#function)
    }
    
    func askQuestion() -> Question? {
        print("Game",#function)
        if gameOver == false {
            print("   ",questionList[currentQuestionIndex])
            return questionList[currentQuestionIndex]
        }
        else {
            print("   ","Game over. There is no more questions!!")
            return nil
        }
    }
    
    func checkAnswer (userAnswer : Int) -> (correctAnswer : Bool, gameOver : Bool, correctAnswerIndex : Int) {
        print("Game",#function)
        if userAnswer == questionList[currentQuestionIndex].correctAnswer {
            print("   ","Correct answer")
            if currentQuestionIndex + 1 >= questionList.count {
                gameOver = true
            }
            return (true, gameOver, questionList[currentQuestionIndex].correctAnswer)
        }
        else {
            gameOver = true
            looseGame = true
            print("   ","Wrong answer")
            return (false, gameOver, questionList[currentQuestionIndex].correctAnswer)
        }
    }
    
    func callFriend() -> Int? {
        print("Game",#function)
        if friendIsAlredyHelpt == false{
            friendIsAlredyHelpt = true
            return Int.random(in: 0...3)
        }
        else {
            return nil
        }
    }
    
    
    func askForAudienceHelp() -> Int? {
        print("Game",#function)
        if audienceIsAlredyHelpt == false{
            audienceIsAlredyHelpt = true
            return Int.random(in: 0...3)
        }
        else {
            return nil
        }
    }
    
    
    func nextQuestion() {
        print("Game",#function)
        if currentQuestionIndex+1 != questionList.count {
            currentQuestionIndex += 1
        }
    }
    
    func addToHistory(userAnswer : Int) {
        print("Game",#function)
        askedQuestions.append(questionList[currentQuestionIndex].question)
        answersForAskedQuestions.append(questionList[currentQuestionIndex].answers[userAnswer])
    }
    
    func prize() -> Int {
        print("Game",#function)
        return currentPrize
    }
    
    func gameStatus() -> Bool{
        print("Game",#function)
        return gameOver
    }
    
    func readFromQuestionsList() -> [Question] {
        print("Game",#function)
        //Чтение массива из файлов ресурсов Questions.plist
        var myArray: NSArray?
        
        var questionsArray : [Question] = []
        
        if let path = Bundle.main.path(forResource: "questions", ofType: "plist") {
            myArray = NSArray(contentsOfFile: path)
        }
        
        if let questionsArrayFromPList = myArray {
            for question in questionsArrayFromPList {
                let questionItem  = question as! Dictionary<String, Any> //приведение к типу массива<Any>
                
                let question: String = questionItem["question"] as! String
                
                let answers : [String] = questionItem["arswerArray"] as! [String]
                
                let correctAnswerIndex: Int = questionItem["correctAnswerIndex"] as! Int
                
                questionsArray.append(Question(question: question, answers: answers, correctAnswer: correctAnswerIndex))
            }
            
        }
        return questionsArray
    }
    
    func saveResults() {
        print("Game",#function)
        
        let newRecord : [String : Any] = ["date" : "\(Date())","answers" : answersForAskedQuestions, "questions" : askedQuestions, "looseGame"  : looseGame, "prize" : currentPrize, "numberOfAskedQuestions" : askedQuestions.count]
        
        //запиcать ответы играка в plist
        //получение папки Documents
        let docsBaseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //получение полного пути файла
        let gameArchivePlistURL = docsBaseURL.appendingPathComponent("gameArchive.plist")
        //сохранение customDict в файл customPlistURL
        
        //если gameArchive уже что-то содерится, то дописать в него новую запись. иначе создать запись впервые
        if var readRecords : [[String : Any]] = NSArray(contentsOf: gameArchivePlistURL) as? [[String : Any]] {
            readRecords.append(newRecord)
            NSArray(array : readRecords).write(to: gameArchivePlistURL, atomically: true)
        }
        else {
            NSArray(array : [newRecord]).write(to: gameArchivePlistURL, atomically: true)
        }
    }
}
