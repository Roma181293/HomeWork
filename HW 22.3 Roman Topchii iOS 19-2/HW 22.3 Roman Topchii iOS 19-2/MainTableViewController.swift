//
//  MainTableViewController.swift
//  HW 22.3 Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 02.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var persons = [Person(name: "Henry VII", dynasty: "Toudor", photo: "Henry VII Toudor.jpg", dynastyLogo: "Tudor"), Person(name: "Elizabeth I", dynasty: "Toudor", photo: "Elizabeth I Toudor.jpg", dynastyLogo: "Tudor"), Person(name: "Elizabeth II", dynasty: "Windsor", photo: "Elizabeth II Windsor.jpg", dynastyLogo: "Windsor"), Person(name: "Louis XIII", dynasty: "Bourbon", photo: "Louis_XIII Bourbon.jpg", dynastyLogo: "Bourbon")]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 131.0
        
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCellId", for: indexPath) as! PersonTableViewCell
        cell.update(with : persons[indexPath.row])

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
             print(persons)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let tmp = persons.remove(at: fromIndexPath.row)
        persons.insert(tmp, at: to.row)
        print(persons)
        
        
    }
    

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
