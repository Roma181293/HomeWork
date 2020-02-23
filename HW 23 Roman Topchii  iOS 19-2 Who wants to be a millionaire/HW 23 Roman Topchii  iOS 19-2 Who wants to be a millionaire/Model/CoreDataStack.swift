//
//  CoreDataStack.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 16.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static var shared = CoreDataStack()
    private init(){}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CoreModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data add categories
    
    func addCategories(_ categories : [Category]) {
        let context = persistentContainer.viewContext
        for category in categories {
            let categoryTmp = DataCategory(context: context)
            categoryTmp.id = category.id
            categoryTmp.categoryName = category.categoryName
            categoryTmp.imageURL = category.imgURL
            categoryTmp.questionURL = category.questionURL
        }
        do {
            try context.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    
    
    // MARK: - Core Data update categories
    
    func updateCategories2(_ categories : [Category]) {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
            
            for category in categories {  //поиск среди новых категорий и добавление в случае отсутствия в БД или обновление в случае нахождения в БД
               
                fetchRequest.predicate = NSPredicate(format: "id = %@", "\(category.id)")
                let storedCategories = try context.fetch(fetchRequest)
                
                if storedCategories.isEmpty {
                    let categoryTmp = DataCategory(context: context)
                    categoryTmp.id = category.id
                    categoryTmp.categoryName = category.categoryName
                    categoryTmp.imageURL = category.imgURL
                    categoryTmp.questionURL = category.questionURL
                }
                else{
                    if category.id == storedCategories[0].id {
                        storedCategories[0].id = category.id
                        storedCategories[0].categoryName = category.categoryName
                        storedCategories[0].imageURL = category.imgURL
                        storedCategories[0].questionURL = category.questionURL
                    }
                }
            }
            
            let fetchRequest2 : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
            let storedCategories = try context.fetch(fetchRequest2)
           
            for storedCategory in storedCategories {
                let filtered = categories.filter{$0.id == storedCategory.id}
                if filtered.isEmpty {
                    context.delete(storedCategory)
                }
            }
            
            try context.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    
    
    
    
    
    // MARK: - Core Data add Questions to Category
    
    func addQuestionsToCategory(questions : [Question], toCategoryId: Int64) {
        let context = persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(toCategoryId)")
        do{
            let result = try context.fetch(fetchRequest)
            
            for question in questions {
                let questionToAdd = DataQuestion(context: context)
                questionToAdd.question = question.question
                questionToAdd.correctAnswer = Int16(question.correctAnswer)
                
                for i in 0...question.answers.count - 1{
                    let answer = DataAnswer(context: context)
                    answer.answer = question.answers[i]
                    questionToAdd.addToAnswers(answer)
                }
                result[0].addToQuestions(questionToAdd)             //add reference to question
            }
            try context.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    
    
    // MARK: - Core Data print CategoriesList
    func printCategory(){
        let context = persistentContainer.viewContext
        let fetchRequestCategory : NSFetchRequest<DataCategory> = DataCategory.fetchRequest()
        
        do {
            let resultCategory = try context.fetch(fetchRequestCategory)
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
    
    
    // MARK: - Core Data print CategoriesList
    func printCategories() -> String? {
        print(#function)
        
        var printinResult = ""
        let context = persistentContainer.viewContext
        let fetchRequestCategory : NSFetchRequest<DataCategory> = DataCategory.fetchRequest()
        do {
            let resultCategory = try context.fetch(fetchRequestCategory)
            for category in resultCategory{
                printinResult += "Category \(category.categoryName!)\n"
                printinResult += "Category \(category.imageURL!)\n"
                printinResult += "Category \(category.questionURL!)\n"
                if let questions = category.questions {
                    for question in questions {
                        printinResult += "-----------------------\n"
                        printinResult += "Category/ question \((question as! DataQuestion).question!)\n"
                        printinResult += "Category/ correctAnswer \((question as! DataQuestion).correctAnswer)\n"
                        for answer in (question as! DataQuestion).answers! {
                            printinResult += "Category/ answer \((answer as! DataAnswer).answer!))\n"
                        }
                    }
                }
                printinResult += "*_*_*_*_*_*_*_*_*_*_*_*_*\n"
            }
            return printinResult
        }
        catch let error {
            print("ERROR", error)
            return nil
        }
    }
    
}
