//
//  Archive Logic.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 12.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation


class Archive {
    //получение папки Documents
    private let docsBaseURL : URL
    //получение полного пути файла
    private let gameArchivePlistURL : URL
    
    
    static let share = Archive()
    
    private init(){
        print("Archive",#function)
        docsBaseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        gameArchivePlistURL = docsBaseURL.appendingPathComponent("gameArchive.plist")
    }
    
    deinit {
        print("Archive",#function)
    }
    
    
    
    private var archive : [[String : Any]] = []
    
    
    
    
    
    func readGameArchive(){
        print("Archive",#function)
        archive = []
        let tmpArchive = NSArray(contentsOf: gameArchivePlistURL) as? [[String : Any]]
        
        
        
        //parsing
        if let tmpArchive = tmpArchive {
            for element in tmpArchive {
                let date = element["date"] as! String
                let questions = element["questions"] as! [String]
                let answers = element["answers"] as! [String]
                let numberOfAskedQuestions = element["numberOfAskedQuestions"] as! Int
                let looseGame = element["looseGame"] as! Bool
                let prize = element["prize"] as! Int
                
                let record : [String : Any] = ["date" : "\(date)","answers" : answers, "questions" : questions, "looseGame"  : looseGame, "prize" : prize, "numberOfAskedQuestions" : numberOfAskedQuestions]
                
                archive.append(record)
            }
        }
    }
    
    func saveChanges() {
        print("Archive",#function)
        NSArray(array : archive).write(to: gameArchivePlistURL, atomically: true)
    }
    
    
    
    func clearAll() {
        print("Archive",#function)
        archive = []
        NSArray(array : []).write(to: gameArchivePlistURL, atomically: true)
    }
    
    
    func moveTo(move currentIndex: Int, to newIndex: Int) {
        print("Archive",#function)
        if currentIndex >= 0 && newIndex >= 0 && currentIndex < archive.count && newIndex < archive.count {
            let tmp = archive.remove(at: currentIndex)
            archive.insert(tmp, at: newIndex)
            //print(archive)
        }
        else {
            print("Check the ranges")
        }
    }
    
    
    func removeElement(at index: Int) {
        print("Archive",#function)
        if index >= 0 && index < archive.count {
            archive.remove(at: index)
        }
        else {
            print("Check the ranges")
        }
    }
    
    
    func count() -> Int{
        print("Archive",#function)
        return archive.count
    }
    
    
    
    func gameInfo(for index: Int) -> (date : String, memo : String)? {
        print("Archive",#function)
        if index >= 0 && index < archive.count {
            var prize = ""
            if archive[index]["prize"] as! Int == 0 {
                prize = "Проигрыш"
            }
            else{
                prize = "\(archive[index]["prize"] as! Int)грн."
            }
            return (date : "\(archive[index]["date"]!)", memo : "\(prize) - \(archive[index]["numberOfAskedQuestions"]!) отв.")
        }
        else {
            print("Check the ranges")
            return nil
        }
    }
    
    
    func gameResults(for index: Int) -> (memo : String ,prize : String, description : String)? {
        print("Archive",#function)
        if index >= 0 && index < archive.count {
            let gameResults = archive[index]
            var description = "Ответы:"
            
            let date = gameResults["date"] as! String
            let questions = gameResults["questions"] as! [String]
            let answers = gameResults["answers"] as! [String]
            let numberOfAskedQuestions = gameResults["numberOfAskedQuestions"] as! Int
            
            
            for index in 0...numberOfAskedQuestions - 1 {
                description += "\n\(index+1). \(questions[index]) : \(answers[index]) "
            }
            
            let prize = "Выигрыш: \(gameResults["prize"] as! Int) грн."
            let memo = "Игра \(date)"
            return (memo : memo ,prize : prize, description : description)
        }
        else {
            return nil
        }
    }
    
}
