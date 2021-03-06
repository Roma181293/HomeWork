//
//  MainViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData


class MainViewController: UIViewController {
    
    var game : Game! = Game.shared
    var coreDataStack = CoreDataStack.shared
    
    var loadNewCategoryListFromServer = false
    var newVersion : Version?
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        spiner.isHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: CGFloat(54.0/255.0), green: CGFloat(41.0/255.0), blue: CGFloat(67.0/255.0), alpha: 1.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
        let currentDBVersion = coreDataStack.getCurrentDBVersion()
             
             if currentDBVersion == nil{
                 coreDataStack.defaultGamesQuestions()
             }
             
             NetworkService.fetchVersion(url: URL(string: "https://raw.githubusercontent.com/Roma181293/MillionaireResouces/master/version.json")!) { (version, error) in
                 if let version = version {
                     if currentDBVersion != version.version   {
                         DispatchQueue.main.async {
                             self.loadNewCategoryListFromServer = true
                             self.newVersion = version
                         }
                     }
                 }
             }
    }
    
    
    @IBAction func startNewGameAction() {
        view.isUserInteractionEnabled = false
        spiner.isHidden = false
        spiner.startAnimating()
        
        if loadNewCategoryListFromServer == true {
            
            let url = URL(string: "https://raw.githubusercontent.com/Roma181293/MillionaireResouces/master/categoryList.json")!
            
            NetworkService.fetchCategory(url: url) { (categories , error) in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if error == nil{
                    DispatchQueue.main.async {
                        self.view.isUserInteractionEnabled = true
                        self.spiner.stopAnimating()
                        self.spiner.isHidden = true
                        self.coreDataStack.updateDBVersion(self.newVersion!)
                        self.coreDataStack.updateCategoriesFromServer(categories!)
                        
                        //MARK:- load question and Image in DataCategory type "Server"
                        let context = self.coreDataStack.persistentContainer.viewContext
                        let fetchRequest : NSFetchRequest<DataCategory> = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
                        fetchRequest.predicate = NSPredicate(format: "type = %@", "Server")
                        do{
                            let result = try context.fetch(fetchRequest)
                            for category in result{
                                if let url = URL(string: category.questionURL!) {
                                    NetworkService.fetchQuestions(url: url) { (questions, error) in
                                        if error == nil {
                                            DispatchQueue.main.async {
                                                self.coreDataStack.addQuestionsToCategory(questions: questions!, toCategoryId: category.id)
                                            }
                                        }
                                        else {
                                            print("Error", error?.localizedDescription as Any)
                                        }
                                    } //NetworkService.fetchQuestions(url: url)
                                }
                            }
                        }
                        catch let error {
                            print("ERROR", error)
                        }
                        //MARK:-load question and Image in DataCategory type "Server"
                        
                        
                        let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseCategoryVC_ID") as! ChooseCategoryTableViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } //if error == nil
            }//NetworkService.fetchCategory(url: url)
        }//if loadNewCategoryListFromServer == true
        else {
            view.isUserInteractionEnabled = true
            spiner.isHidden = true
            spiner.stopAnimating()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseCategoryVC_ID") as! ChooseCategoryTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
