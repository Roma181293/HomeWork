//
//  Game.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation

class Game {
    
    
    static var shared : Game = Game()
    
    private init() {
        print("Game",#function, "singleton")
        
    }
    
    
    private var questionList : [Question] = []
    private var currentQuestionIndex : Int = 0
    
    private let prizeArray : [Int] = [500,2000,5000,10000,15000,25000,50000,100000,200000,400000,800000,1000000]
    
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
    private var fiftyFiftyIsAlredyHelpt : Bool = false
    private var fiftyFiftyResult : (firsrAnswer: Int, secondAnswer: Int, currentQuestionIndex: Int)?
    
    func newGame(questions : [Question]) {
        questionList = questions
        currentQuestionIndex = 0
        gameOver = false
        looseGame = false
        askedQuestions = []
        answersForAskedQuestions = []
        friendIsAlredyHelpt = false
        audienceIsAlredyHelpt = false
        fiftyFiftyIsAlredyHelpt = false
        
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
    
    func checkAnswer (userAnswerIndex : Int) -> (isRightAnswer : Bool, gameOver : Bool, correctAnswerIndex : Int) {
        print("Game",#function)
        if userAnswerIndex == questionList[currentQuestionIndex].correctAnswer {
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
            if currentQuestionIndex != fiftyFiftyResult?.currentQuestionIndex{
                let res = Int.random(in: 0...3)
                print(#function,"rand", res)
                return res
            }
            else {
                var set : Set<Int> = [0,1,2,3]
                set.subtract([fiftyFiftyResult!.firsrAnswer, fiftyFiftyResult!.secondAnswer])
                let res = set.randomElement()
                print(#function,"set", res)
                return res
            }
        }
        else {
            return nil
        }
    }
    
    
    func fiftyFifty() -> (firsrAnswer: Int, secondAnswer: Int, currentQuestionIndex: Int)? { // результат ответы которые нужно скрыть на экран
        print("Game",#function)
        if fiftyFiftyIsAlredyHelpt == false{
            fiftyFiftyIsAlredyHelpt = true
            
            var first = 0
            var second = 1
            while  first == questionList[currentQuestionIndex].correctAnswer || second == questionList[currentQuestionIndex].correctAnswer || first == second{
                first = Int.random(in: 0...3)
                second = Int.random(in: 0...3)
            }
            fiftyFiftyResult = (first, second, currentQuestionIndex)
            return (first, second, currentQuestionIndex)
        }
        else {
            return nil
        }
    }
    
    func askForAudienceHelp() -> (first : Double, second : Double, third : Double, fourth : Double)? {
        print("Game",#function)
        if audienceIsAlredyHelpt == false{
            audienceIsAlredyHelpt = true
            
            var first : Double
            var second : Double
            var third : Double
            var fourth : Double
            
            
            switch questionList[currentQuestionIndex].correctAnswer {
            case 0 :
                first = Double.random(in: 0.25...0.6)
                second = Double.random(in: 0...1 - first)
                third = Double.random(in: 0...1 - first - second)
                fourth = 1 - first - second - third
            case 1 :
                second = Double.random(in: 0.25...0.6)
                first = Double.random(in: 0...1 - second)
                third = Double.random(in: 0...1 - first - second)
                fourth = 1 - first - second - third
            case 2 :
                third = Double.random(in: 0.25...0.6)
                second = Double.random(in: 0...1 - third)
                first = Double.random(in: 0...1 - third - second)
                fourth = 1 - first - second - third
            default :
                fourth = Double.random(in: 0.25...0.6)
                first = Double.random(in: 0...1 - fourth)
                second = Double.random(in: 0...1 - first - fourth)
                third = 1 - first - second - fourth
            }
            
            return (first : first, second : second, third : third, fourth : fourth)
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
    
    func isGameOver() -> Bool{
        print("Game",#function)
        return gameOver
    }
    
    func canGetHelp() -> (audience : Bool, friend : Bool, fiftyFifty : Bool) {
        return (audienceIsAlredyHelpt, friendIsAlredyHelpt, fiftyFiftyIsAlredyHelpt)
    }
    
    func saveResults() {
        print("Game",#function)
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let dateString = dateFormatter.string(from:date as Date)
        
        let newRecord : [String : Any] = ["date" : dateString,"answers" : answersForAskedQuestions, "questions" : askedQuestions, "looseGame"  : looseGame, "prize" : currentPrize, "numberOfAskedQuestions" : askedQuestions.count]
        
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
