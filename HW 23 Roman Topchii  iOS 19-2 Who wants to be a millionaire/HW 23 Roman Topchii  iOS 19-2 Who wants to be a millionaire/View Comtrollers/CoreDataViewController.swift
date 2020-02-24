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
    
    
    let coreDataStack = CoreDataStack.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   MARK: -- Загрузка и внесение в БД категорий
//        let url = URL(string: "https://raw.githubusercontent.com/Roma181293/MillionaireResouces/master/categoryList.json")!
        
        //        NetworkService.fetchCategory(url: url) { (categories , error) in
        //            if error == nil{
        //                DispatchQueue.main.async {
        //                    self.coreDataStack.updateCategoriesFromServerTest(categories!)
        //                }
        //            }
        //            else {
        //                print("Error", error?.localizedDescription)
        //            }
        //        } // NetworkService.fetchCategory(url: url)
        
        
        
        
        
     //   MARK: -- Загрузка и внесение в БД вопросов по ссылкам категорий
//        let context = coreDataStack.persistentContainer.viewContext
//        let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
//
//        do{
//            let result = try context.fetch(fetchRequest)
//            for category in result{
//                if let url = URL(string: category.questionURL!) {
//                    NetworkService.fetchQuestions(url: url) { (questions, error) in
//                        if error == nil {
//                            DispatchQueue.main.async {
//                                self.coreDataStack.addQuestionsToCategory(questions: questions!, toCategoryId: category.id)
//                            }
//                        }
//                        else {
//                            print("Error", error?.localizedDescription)
//                        }
//                    } //NetworkService.fetchQuestions(url: url)
//                }
//            }
//
//        }
//        catch let error {
//            print("ERROR", error)
//        }
        
        
        
//        coreDataStack.printCategory()
        
        
        //   MARK: Загрузка версии вопросов на сервере
//        NetworkService.fetchVersion(url: URL(string: "https://raw.githubusercontent.com/Roma181293/MillionaireResouces/master/version.json")!) { (version, error) in
//            if error == nil {
//                DispatchQueue.main.async {
//                    print("version", version!)
//                }
//            }
//            else {
//                print("Errors", error?.localizedDescription)
//            }
//        }
        
        
        
        
        
        
    } //viewDidLoad()
    
    
    
}
