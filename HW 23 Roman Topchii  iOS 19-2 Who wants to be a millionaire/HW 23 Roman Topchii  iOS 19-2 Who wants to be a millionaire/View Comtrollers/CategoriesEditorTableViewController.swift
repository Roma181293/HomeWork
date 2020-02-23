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
    
   lazy var fetchedResultsController : NSFetchedResultsController<DataCategory> = {
           let fetchRequest = NSFetchRequest<DataCategory>(entityName: "DataCategory")
           fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
           let context = CoreDataStack.shared.persistentContainer.viewContext
           
           let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
           return frc
       }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
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
        
        //cell.imageURL = URL(string:category.imageURL!)!
        cell.stringCategoryName = category.categoryName
        
        return cell
    }
    
    
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
     }
     */
    
}
