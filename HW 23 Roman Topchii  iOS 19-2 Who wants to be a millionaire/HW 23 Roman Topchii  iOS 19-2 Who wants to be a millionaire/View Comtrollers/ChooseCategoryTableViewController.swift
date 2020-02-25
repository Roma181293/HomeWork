//
//  ChooseCategoryTableViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 31.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData

class ChooseCategoryTableViewController: UITableViewController {
    
    var game : Game! = Game.shared
    
    lazy var fetchedResultsController : NSFetchedResultsController<DataCategory> = {
        let fetchRequest = NSFetchRequest<DataCategory>(entityName: DataCategory.entity().name!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true),NSSortDescriptor(key: "id", ascending: true)]
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.title = "Категории"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 245.0/255.0, green: 242/255.0, blue: 240/255.0, alpha: 1)]
        
        do {
            try fetchedResultsController.performFetch()
        }
        catch {
            print(error)
        }
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = fetchedResultsController.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseCell_ID", for: indexPath) as! CategoryTableViewCell
        
        let category  = fetchedResultsController.object(at: indexPath) as DataCategory
        
        //set Image
        if let url = category.imageURL{
            cell.imageURL = URL(string:url)!
        }
        else if category.type == "User" {
            cell.setImageForCategoryType = .User
        }
        else {
            cell.setImageForCategoryType = .Preinstall
        }
        
        cell.stringCategoryName = category.categoryName
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        cell.startAnimatingSpiner(cell.loadSpiner)
        
        let category  = fetchedResultsController.object(at: indexPath) as DataCategory
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let questionVC = storyBoard.instantiateViewController(withIdentifier: "QuestionVC_ID") as! QuestionViewController
        
        if category.questions?.count != 0 {     //проверка наличия вопросов в категории
            var questionArray : [Question] = []
            for item in category.questions! {
                questionArray.append(Question(dataQuestion: item as! DataQuestion))
            }
            self.game.newGame(questions: questionArray)
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
        else if category.type == "Server" {
            if let questionURL = category.questionURL, let url = URL(string: questionURL){
                NetworkService.fetchQuestions(url: url) { (questions, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            cell.stopAnimatingSpiner(cell.loadSpiner)
                            if let questions = questions {
                                self.game.newGame(questions: questions)
                                self.navigationController?.pushViewController(questionVC, animated: true)
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            cell.stopAnimatingSpiner(cell.loadSpiner)
                            
                            
                            let alert = UIAlertController(title: "Упс. Не удалось загрузить вопросы.", message: nil, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Главное меню", style: .default, handler: { action in
                                print("Главное меню")
                                let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainVC_ID") as! MainViewController
                                self.navigationController?.pushViewController(mainVC, animated: true)
                            }))
                            
                            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { action in
                                print("Закрыть")
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                }
            }
        }//else if
        else {  //когда это пользовательские темы без вопросов
            let alert = UIAlertController(title: "В созданной вами категории \"\(category.categoryName!)\" нет вопросов!", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Главное меню", style: .default, handler: { action in
                print("Главное меню")
                let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainVC_ID") as! MainViewController
                self.navigationController?.pushViewController(mainVC, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { action in
                print("Закрыть")
            }))
            
            self.present(alert, animated: true, completion: nil)
            cell.stopAnimatingSpiner(cell.loadSpiner)
        }
        
    } //override
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     //        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {return}
     
     
     }
     */
    
}
