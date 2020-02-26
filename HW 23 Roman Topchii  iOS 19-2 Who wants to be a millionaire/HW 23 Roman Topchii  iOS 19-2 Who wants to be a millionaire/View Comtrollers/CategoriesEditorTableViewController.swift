//
//  CategoriesEditorTableViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 23.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData

class CategoriesEditorTableViewController: UITableViewController {
    
    let coreDataStack = CoreDataStack.shared
    
    lazy var fetchedResultsController : NSFetchedResultsController<DataCategory> = {
        let fetchRequest = NSFetchRequest<DataCategory>(entityName: "DataCategory")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        //        fetchRequest.predicate = NSPredicate(format: "type = %@", "User")
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.clearsSelectionOnViewWillAppear = true
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 245.0/255.0, green: 242/255.0, blue: 240/255.0, alpha: 1)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell_ID", for: indexPath) as! CategoryForEditorTableViewCell
        let category  = fetchedResultsController.object(at: indexPath) as DataCategory
        cell.textLabel?.text = category.categoryName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category  = fetchedResultsController.object(at: indexPath) as DataCategory
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "QuestionsEditorVC_ID") as! QuestionsEditorTableViewController
        vc.categoryId = category.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
