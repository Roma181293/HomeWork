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
        addCategory([Category(id: 0, categoryName: "sport", imgURL: "urlImg", questionURL: "URLQuest"), Category(id: 1, categoryName: "hishory", imgURL: "urlImg", questionURL: "URLQuest"), Category(id: 2, categoryName: "music", imgURL: "urlImg", questionURL: "URLQuest")])
        
        addQuestionsToCategory(questions :[Question(question: "Who5?", answers: ["false","false","true","false"], correctAnswer: 2),Question(question: "Who6?", answers: ["false","false","false","true"], correctAnswer: 3)], toCategoryId: 0)
        printCategory()
    }
    
    
    func addCategory(_ categories : [Category]) {
        for category in categories {
            let categoryTmp = DataCategory(context: managedContext)
            categoryTmp.id = category.id
            categoryTmp.categoryName = category.categoryName
            categoryTmp.imageURL = category.imgURL
            categoryTmp.questionURL = category.questionURL
        }
        do {
            try managedContext.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    func addQuestionsToCategory(questions : [Question], toCategoryId: Int64) {
        let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(toCategoryId)")
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            for question in questions {
                let questionToAdd = DataQuestion(context: managedContext)
                questionToAdd.question = question.question
                questionToAdd.correctAnswer = Int16(question.correctAnswer)
                
                for i in 0...question.answers.count - 1{
                    let answer = DataAnswer(context: managedContext)
                    answer.answer = question.answers[i]
                    questionToAdd.addToAnswers(answer)
                }
                result[0].addToQuestions(questionToAdd)             //add reference to question
            }
            try managedContext.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    
    func printCategory(){
        let fetchRequestCategory : NSFetchRequest<DataCategory> = DataCategory.fetchRequest()
        
        do {
            let resultCategory = try managedContext.fetch(fetchRequestCategory)
            for category in resultCategory{
                print("Category", category.id)
                print("Category", category.categoryName!)
                print("Category", category.imageURL!)
                print("Category", category.questionURL!)
                if let questions = category.questions {
                    for question in questions {
                        print("-----------------------")
                        print("Category/ question", (question as! DataQuestion).question!)
                        print("Category/ correctAnswer", (question as! DataQuestion).correctAnswer)
                        for answer in (question as! DataQuestion).answers! {
                            print("Category/ answer", (answer as! DataAnswer).answer!)
                        }
                    }
                }
                print("*_*_*_*_*_*_*_*_*_*_*_*_*\n")
            }
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
}
