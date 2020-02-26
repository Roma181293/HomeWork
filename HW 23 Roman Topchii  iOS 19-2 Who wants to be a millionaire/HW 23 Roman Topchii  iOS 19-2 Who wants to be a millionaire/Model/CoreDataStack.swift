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
    
    func addLocalCategory(categoryName : String, categoryType: String) -> DataCategory?  {
        let context = persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
        fetchRequest.predicate = NSPredicate(format: "type = %@", "Server")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        let category = DataCategory(context: context)
        category.type = categoryType
        category.categoryName = categoryName
        
        let question = DataQuestion(context: context)
        question.question = ""
        question.correctAnswer = 0
        for _ in 0...3 {
            let answer = DataAnswer(context: context)
            answer.answer = ""
            question.addToAnswers(answer)
        }
        category.addToQuestions(question)
        
        do{
            let storedCategories = try context.fetch(fetchRequest)
            
            if storedCategories.isEmpty == false {
                category.id = storedCategories[0].id + 1
            }
            else {
                category.id = 1
            }
            try context.save()
            return category
        }
        catch let error {
            print("ERROR", error)
            return nil
        }
    }
    
    
    
    // MARK: - Core Data update categories
    
    func updateCategoriesFromServer(_ categories : [Category]) {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
            fetchRequest.predicate = NSPredicate(format: "type = %@", "Server")
            
            var storedCategories = try context.fetch(fetchRequest)
            print("storedCategories.count", storedCategories.count)
            //Если серверные категории есть, то удаляем их
            if storedCategories.isEmpty == false {
                for category in storedCategories {
                    context.delete(category)
                }
            }
            
            try context.save()
            
            storedCategories = try context.fetch(fetchRequest)
            print("storedCategories.count", storedCategories.count)
            //добавляем серверные категории
            if storedCategories.isEmpty {
                for category in categories {
                    let categoryTmp = DataCategory(context: context)
                    categoryTmp.id = category.id
                    categoryTmp.type = "Server"
                    categoryTmp.categoryName = category.categoryName
                    categoryTmp.imageURL = category.imgURL
                    categoryTmp.questionURL = category.questionURL
                }
            }
            
            try context.save()
            storedCategories = try context.fetch(fetchRequest)
            print("storedCategories.count", storedCategories.count)
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
            if result.isEmpty == false {
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
            }
            try context.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    
    
    
    
    
    // MARK: - Core Data add Questions to Category
    
    //       func addQImageToCategory(image : Data, toCategoryId: Int64) {
    //           let context = persistentContainer.viewContext
    //           let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
    //           fetchRequest.predicate = NSPredicate(format: "id = %@", "\(toCategoryId)")
    //           do{
    //               let result = try context.fetch(fetchRequest)
    //            if result.isEmpty == false {
    //               // result[0].image
    //            }
    //               try context.save()
    //           }
    //           catch let error {
    //               print("ERROR", error)
    //           }
    //       }
    
    
    
    
    
    
    
    
    // MARK: - Core Data print CategoriesList
    //    func printCategories(){
    //        let context = persistentContainer.viewContext
    //        let fetchRequestCategory : NSFetchRequest<DataCategory> = DataCategory.fetchRequest()
    //
    //        do {
    //            let resultCategory = try context.fetch(fetchRequestCategory)
    //            for category in resultCategory{
    //                print("Category", category.id)
    //                print("Category", category.type)
    //                print("Category", category.categoryName!)
    //                print("Category", category.imageURL)
    //                print("Category", category.questionURL)
    //                if let questions = category.questions {
    //                    for question in questions {
    //                        print("-----------------------")
    //                        print("Category/ question", (question as! DataQuestion).question)
    //                        print("Category/ correctAnswer", (question as! DataQuestion).correctAnswer)
    //                        for answer in (question as! DataQuestion).answers!{
    //                            print("Category/ answer", (answer as! DataAnswer).answer)
    //                        }
    //                    }
    //                }
    //                print("*_*_*_*_*_*_*_*_*_*_*_*_*\n")
    //            }
    //        }
    //        catch let error {
    //            print("ERROR", error)
    //        }
    //    }
    
    
    
    
    
    // MARK: -- Core Data Version Methods
    
    func updateDBVersion(_ newVersion : Version) {
        let context = persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<DataVersion> = NSFetchRequest<DataVersion>(entityName: DataVersion.entity().name!)
        do{
            let result = try context.fetch(fetchRequest)
            if result.isEmpty == false {
                result[0].version = newVersion.version
                result[0].author = newVersion.author
            }
            else {
                let version = DataVersion(context: context)
                version.version = 0
                version.author = "Device"
            }
            try context.save()
        }
        catch let error {
            print("ERROR", error)
        }
    }
    
    func getCurrentDBVersion () -> Int64? {
        let context = persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<DataVersion> = NSFetchRequest<DataVersion>(entityName: DataVersion.entity().name!)
        do{
            let result = try context.fetch(fetchRequest)
            if result.isEmpty {
                return nil
            }
            else {
                return result[0].version
            }
            
        }
        catch let error {
            print("ERROR", error)
            return nil
        }
    }
    
    
    
    
    
    
    func defaultGamesQuestions() {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
            fetchRequest.predicate = NSPredicate(format: "type = %@", "Preinstall")
            
            let storedCategories = try context.fetch(fetchRequest)
            print("storedCategories.count", storedCategories.count)
            //Если серверные категории есть, то удаляем их
            if storedCategories.isEmpty == false {
                for category in storedCategories {
                    context.delete(category)
                }
            }
            
            try context.save()
            
            let category1 = DataCategory(context: context)
            category1.id = 1
            category1.type = "Preinstall"
            category1.categoryName = "Общие знания"
            
            
            let question1 = DataQuestion(context: context)
            question1.question = "Кто собирался открыть Индию, а открыл Америку?"
            question1.correctAnswer = 1
            let ans1 = DataAnswer(context: context)
            let ans2 = DataAnswer(context: context)
            let ans3 = DataAnswer(context: context)
            let ans4 = DataAnswer(context: context)
            
            ans1.answer = "Марко Поло"
            ans2.answer = "Коллумб"
            ans3.answer = "Магелан"
            ans4.answer = "Васко де Гама"
            question1.addToAnswers(ans1)
            question1.addToAnswers(ans2)
            question1.addToAnswers(ans3)
            question1.addToAnswers(ans4)
            category1.addToQuestions(question1)
            
            
            
            let question2 = DataQuestion(context: context)
            question2.question = "Во что должен попасть спортсмен в стендовой стрельбе?"
            question2.correctAnswer = 2
            let ans5 = DataAnswer(context: context)
            let ans6 = DataAnswer(context: context)
            let ans7 = DataAnswer(context: context)
            let ans8 = DataAnswer(context: context)
            
            ans5.answer = "Ядро"
            ans6.answer = "Ложку"
            ans7.answer = "Тарелку"
            ans8.answer = "Плечо соперника"
            question2.addToAnswers(ans5)
            question2.addToAnswers(ans6)
            question2.addToAnswers(ans7)
            question2.addToAnswers(ans8)
            category1.addToQuestions(question2)
            
            
            let question3 = DataQuestion(context: context)
            question3.question = "Историю какого города написал Никколо Макиавелли?"
            question3.correctAnswer = 0
            let ans9 = DataAnswer(context: context)
            let ans10 = DataAnswer(context: context)
            let ans11 = DataAnswer(context: context)
            let ans12 = DataAnswer(context: context)
            
            ans9.answer = "Флоренция"
            ans10.answer = "Венеция"
            ans11.answer = "Рим"
            ans12.answer = "Неаполь"
            question3.addToAnswers(ans9)
            question3.addToAnswers(ans10)
            question3.addToAnswers(ans11)
            question3.addToAnswers(ans12)
            category1.addToQuestions(question3)
            
            try context.save()
            
        }
        catch let error {
            print("ERROR", error)
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
