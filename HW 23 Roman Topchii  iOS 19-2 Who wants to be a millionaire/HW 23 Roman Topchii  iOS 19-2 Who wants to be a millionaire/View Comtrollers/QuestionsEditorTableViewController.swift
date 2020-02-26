//
//  QuestionsEditorTableViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 24.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData

class QuestionsEditorTableViewController: UITableViewController {
    
    var categoryId : Int64?
    
    lazy var fetchedResultsController : NSFetchedResultsController<DataQuestion> = {
        let fetchRequest = NSFetchRequest<DataQuestion>(entityName: "DataQuestion")
        fetchRequest.predicate = NSPredicate(format: "categoty.id = %@", "\(categoryId!)")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "question", ascending: true)]
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 245.0/255.0, green: 242/255.0, blue: 240/255.0, alpha: 1)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        if let count = fetchedResultsController.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {  let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell_ID", for: indexPath)
        
        let question  = fetchedResultsController.object(at: indexPath) as DataQuestion
        cell.textLabel?.text = question.question!
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let question  = fetchedResultsController.object(at: indexPath) as DataQuestion
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "QuestionEditorVC_ID") as! QuestionEditorViewController
        
        vc.inputQuestion = Question(dataQuestion : question)
        vc.categoryId = categoryId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
