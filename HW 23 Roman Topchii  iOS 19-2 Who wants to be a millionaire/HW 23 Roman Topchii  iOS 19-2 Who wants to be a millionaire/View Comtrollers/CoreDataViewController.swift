//
//  CoreDataViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 16.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    
    let managedContext = CoreDataStack.shared.persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addQuestion(Question(question: "Who2?", answers: ["false","false","true","false"], correctAnswer: 2))
        addQuestion(Question(question: "Who3?", answers: ["false","false","false","true"], correctAnswer: 3))
        
        let fetchRequest : NSFetchRequest<DataQuestion> = DataQuestion.fetchRequest()
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            for item in result {
                print(item.question!)
                if let answers = item.answers{
                    for i in 0...answers.count - 1 {
                        print((item.answers![i] as! DataAnswer).answer!)
                    }
                }
                print(item.correctAnswer)
                print("-----")
            }
            
        }
        catch let error {
            print("ERROR", error)
        }
        
        
        
        
        addCategory(Category(categoryName: "sport", imgURL: "urlImg", questionURL: "URLQuest"))
        
        
        
        
        
        var fetchRequestCategory : NSFetchRequest<DataCategory> = DataCategory.fetchRequest()
        do{
            let resultCategory = try managedContext.fetch(fetchRequestCategory)
            let resultQuestion = try managedContext.fetch(fetchRequest)
            for question in resultQuestion {
                resultCategory[1].addToQuestions(question)
            }
            try managedContext.save()
        }
        catch let error {
            print("ERROR", error)
        }
        
        
        
        fetchRequestCategory = DataCategory.fetchRequest()
        
        do{
            let resultCategory = try managedContext.fetch(fetchRequestCategory)
            for category in resultCategory{
                print("Category", category.categoryName!)
                print("Category", category.imageURL!)
                print("Category", category.questionURL!)
                if let questions = category.questions {
                    for question in questions {
                        print("Category/ question", (question as! DataQuestion).question!)
                        print("Category/correctAnswer ", (question as! DataQuestion).correctAnswer)
                        for answer in (question as! DataQuestion).answers! {
                            print("Category/ answer", (answer as! DataAnswer).answer!)
                        }
                    }
                }
                print("*_*_*_*_*_*_*_*_*_*_*_*_*")
            }
        }
        catch let error {
            print("ERROR", error)
        }
        
        
    }
    
    
    
    func addCategory(_ category : Category) {
        let categoryTmp = DataCategory(context: managedContext)
        categoryTmp.categoryName = category.categoryName
        categoryTmp.imageURL = category.imgURL
        categoryTmp.questionURL = category.questionURL
        
        do {
            try managedContext.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    func addQuestion(_ question : Question) {
        let question1 = DataQuestion(context: managedContext)
        question1.question = question.question
        question1.correctAnswer = Int16(question.correctAnswer)
        
        for i in 0...question.answers.count - 1{
            let answer = DataAnswer(context: managedContext)
            answer.answer = question.answers[i]
            question1.addToAnswers(answer)
        }
        
        do {
            try managedContext.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
